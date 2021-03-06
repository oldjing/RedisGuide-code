-- 打开目录传播模式
-- 以便在执行 SRANDMEMBER 之后继续执行 DEL
redis.replicate_commands()

-- 集合键
local set_a = KEYS[1]
local set_b = KEYS[2]
local result_key = KEYS[3]

-- 随机元素的数量
local count = tonumber(ARGV[1])

-- 计算并集，随机选出指定数量的并集元素，然后删除并集
redis.call('SUNIONSTORE', result_key, set_a, set_b)
local elements = redis.call('SRANDMEMBER', result_key, count)
redis.call('DEL', result_key)

-- 返回随机选出的并集元素
return elements
