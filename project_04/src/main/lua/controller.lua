---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by cun8c.
--- DateTime: 2019/7/1 15:50
---需求：集成lua和kafka模块，将nginx的请求及请求参数写入到kafka的集群
---代码实现思路：
---1：初始化最大活跃连接数及kafka的相关参数
---2：获取写入kafka集群的相关参数并拼接成字符串
---3：导入kafka的依赖模块
---4：将拼接好的字符串发送到kafka集群
---设置最大活跃连接数为1000，作为保护机制
local maxUserNumber = 1000
---指定kafka集群地址
local broker_list = {
    { host = "192.168.83.110", port = 9092 },
    { host = "192.168.83.120", port = 9092 },
    { host = "192.168.83.130", port = 9092 }
}
---设置topic。将数据写到哪个topicKafkaTopic
local topic = "B2CDATA_COLLECTION01"
---自定义分区数量，该值一定要跟实际分区的数量保持
local partition_num = 3
---自定义分区器，因为默认的分区器不好用，传一个key，返回key，key就是我们的分区id
local function partitioner(key)
    return tonumber(key)
end
---设置生产者相关的配置参数
local producer_config = { request_timeout = 2000, partitioner = partitioner }

---共享内存变量使用
---定义一个共享内存的key
local polling_key = "POLLING_KEY"
---获取nginx的共享内存
local shared_data = ngx.shared.shared_data
---在共享内存中获取指定的key
local polling_value = shared_data:get(polling_key)
---如果在共享内存中没有获取到计数器的值，则给一个默认值
if not polling_value then
    polling_value = 0
    shared_data:set(polling_key, polling_value)
end
---将polling_value的值进行自增操作
shared_data:incr(polling_key, 1)

---根据计数器的值，推算出来这个值应该放到哪个分区  发送的数据需要是字符串形式的 所有拼接一个""
--- 计数器 % 分区数 = 分区数的id
local partitionid = "" .. (tonumber(polling_value) % partition_num)

---打印计数器的值
ngx.say("count：", polling_value)

--设置阈值，如果当前活跃连接数大于设置的最大活跃连接数，则不写入kafka数据
local isGone = true
--判断当前活跃连接数是否超过了阈值
if (tonumber(ngx.var.connections_active) > maxUserNumber) then
    isGone = false
end
---如果低于阈值的条件，才可以采集数据生产到kafka
if isGone then
    --访问时间
    local time_local = ngx.var.time_local
    if time_local == nil then
        time_local = ""
    end
    --请求的连接
    local request = ngx.var.request
    if request == nil then
        request = ""
    end
    --请求的方式
    local request_method = ngx.var.request_method
    if request_method == nil then
        request_method = ""
    end
    --content_type头信息
    local content_type = ngx.var.content_type
    if content_type == nil then
        content_type = ""
    end
    --读取body信息
    ngx.req.read_body()
    --请求参数
    local request_body = ngx.var.request_body
    if request_body == nil then
        request_body = ""
    end
    --跳转来源
    local http_referer = ngx.var.http_referer
    if http_referer == nil then
        http_referer = ""
    end
    --客户端地址
    local remote_addr = ngx.var.remote_addr
    if remote_addr == nil then
        remote_addr = ""
    end
    --用户代理
    local http_user_agent = ngx.var.http_user_agent
    if http_user_agent == nil then
        http_user_agent = ""
    end
    --带时区的访问时间
    local time_iso8601 = ngx.var.time_iso8601
    if time_iso8601 == nil then
        time_iso8601 = ""
    end
    --服务器地址
    local server_addr = ngx.var.server_addr
    if server_addr == nil then
        server_addr = ""
    end
    --cookie信息
    local http_cookie = ngx.var.http_cookie
    if http_cookie == nil then
        http_cookie = ""
    end
    --封装数据
    local message = time_local .. "#CS#" .. request .. "#CS#" .. request_method .. "#CS#" .. content_type .. "#CS#" .. request_body .. "#CS#" .. http_referer .. "#CS#" .. remote_addr .. "#CS#" .. http_user_agent .. "#CS#" .. time_iso8601 .. "#CS#" .. server_addr .. "#CS#" .. http_cookie .. "#CS#" .. ngx.var.connections_active;
    --导入kafka的依赖包
    local producerPAC = require("resty.kafka.producer")
    --使用producer创建producer的实例
    local producer = producerPAC:new(broker_list, producer_config)
    --发送消息
    local ok, err = producer:send(topic, partitionid, message)
    --打印日志
    if not ok then
        ngx.log(ngx.ERR, "kafka send message err:", err)
    end
end
