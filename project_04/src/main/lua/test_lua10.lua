---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by cun8c.
--- DateTime: 2019/7/1 11:00
---1：获取uri参数，也就是获取get请求的参数
local getArgs = ngx.req.get_uri_args()
---获取到的所有的参数进行打印到浏览器
for k, v in pairs(getArgs) do
    ngx.say("GET KEY：", k, ", VLAUE：", v)
    ngx.say("<br />")
end

---2：获取post的请求参数
---POST KEY：addr, VLAUE：beijing
--POST KEY：phone, VLAUE：12121212
---适合用于需要对指定的参数进行二次处理的场景
---如果不写ngx.req.read_body()，抛出异常
ngx.req.read_body() --在解析body之前一定要先读取body
local postArgs = ngx.req.get_post_args()
for k, v in pairs(postArgs) do
    ngx.say("POST KEY：", k, ", VLAUE：", v)
    ngx.say("<br />")
end

--3：获取header信息
local headers = ngx.req.get_headers()
for k,v in pairs(headers) do
    ngx.say("HEADER KEY：", k, ", VLAUE：", v)
    ngx.say("<br />")
end

--4：读取body信息
--BODYDATA：phone=12121212&addr=beijing
--适合用在将请求参数原样不动的传输的时候
--如果不写ngx.req.read_body()， 不会报错，但是取不到参数
local data = ngx.req.get_body_data()
ngx.say("BODYDATA：", data)