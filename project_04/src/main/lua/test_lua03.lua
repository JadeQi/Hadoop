---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by cun8c.
--- DateTime: 2019/7/1 9:34
---
---条件控制
print("==================if======================")
a, b = 1, 2
if(a<b) then
    print("a<b")
end

print("==================if== else=================")
if(a>b) then
    print("a>b")
else
    print("a<b")
end

print("==================if嵌套=================")
if(a<b) then
    if(b>=2) then
        print("b>=2")
    end
end

print("==================while=================")
e =3
while(e>0) do
    print(e)
    e = e -1
end

print("==================repeat until=================")
f = 3
repeat
    print(f)
    f = f -1
until(f<0)

print("========================while和repeat until的区别============================")
g = 3
while(g>0) do                   --先判断再执行
    print("while"..g)
    g = g-1
end

g = 3
repeat                          --先执行再判断，类似于do while
    print("reptat:"..g)
    g = g-1
until(g<0)

print("==================for=================")
--数值for循环
for i=1, 10, 2 do
    --if(i%2 == 0) then
        print("i=" .. i)
    --end
end
--泛型for循环