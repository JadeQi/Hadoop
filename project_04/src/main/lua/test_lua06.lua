---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by cun8c.
--- DateTime: 2019/7/1 10:00
---
local function funcName(a,b, c)
    print(a,b,c)
    return a, b, c
end

function funcName2(a,b, c)
    print(a,b,c)
    return a, b, c
end

a,b,c = funcName2(10,20,30)
print(a, b, c)

--后续经常会出现，使用多个变量接收函数的返回值
--发送消息：
--ok, err = producer.send(topic, key, message)
--函数的返回值根接受返回值的变量名称没有丝毫关系，只跟返回顺序有关