---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by cun8c.
--- DateTime: 2019/7/1 10:20
---调用生产者模块，发送消息到kafka
---使用require引入模块，不需要指定模块的后缀名，如果引入的模块和当前的脚本文件不再同一个目录，需要指定目录
require("producer")

--打印引入模块的默认分区数
print(_M.default_partition_nums)

--实例化生产者对象
print(_M.new())

--调用发送消息
print(_M.send("hello"))
