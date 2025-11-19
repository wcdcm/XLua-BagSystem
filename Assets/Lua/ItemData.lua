--从AB包中加载json资源
--txt是从json文件中读取出来的文本信息，是TextAsset类型的
local txt = ABMgr:LoadRes("json","ItemData",typeof(TextAsset))

--将Json数据反序列化为lua表结构
local itemList = Json.decode(txt.text)

--itemList加载出来是一个类似于数组(table)的数据结构
--其中的每一个元素都是一个字典(table)
--这样的结构不方便我们通过id直接去访问里面的内容，所以我们用新表转存一次,让当前表中的id作为新表的键
--我们将这张新表设置为全局变量，方便我们在程序各处都能访问
ItemData = {}

for _, value in pairs(itemList) do
    --自定义索引，让itemList里的每个值对应的id作为新表的键，将itemList的值作为新表的值
    ItemData[value.id] = value
end

--for key, value in pairs(ItemData) do
--    print(key,value)
--end