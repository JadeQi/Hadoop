---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by cun8c.
--- DateTime: 2019/7/1 10:15
---这是我们自己定义的模块（模拟kafka的生产者），模块是由变量和函数组成，将变量和函数放在table中，将table返回
local _M = {}
---扩展一个默认分区属性
_M.default_partition_nums = 3

---模拟函数的初始化（生产者的实例化）
function _M.new()
    return "producer"
end

--模拟一个发送消息的函数
function _M.send(message)
    return "ok"
end

return _M




