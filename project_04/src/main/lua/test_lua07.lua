---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by cun8c.
--- DateTime: 2019/7/1 10:07
---table的应用
mytable = {}
mytable.first = "zhangsan"
mytable.second = "lisi"

print(mytable[1])
print(mytable.first)
print(mytable["second"])

---table的应用
kafkaHosts = {
    { host = "bigdata111", port=9092},
    { host = "bigdata112", port=9092},
    { host = "bigdata113", port=9092}
}
