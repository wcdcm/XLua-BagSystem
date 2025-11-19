PlayerData = {}

PlayerData.equips = {}
PlayerData.items = {}
PlayerData.gems = {}

--玩家数据初始化方法
--玩家的道具数据只会存储道具对应的id和数量，根据id到对应的道具表里搜索对应的数据
function PlayerData:Init()
    table.insert(self.equips,{id = 1,num = 1})
    table.insert(self.equips,{id = 2,num = 1})
    
    table.insert(self.items,{id = 3,num = 50})
    table.insert(self.items,{id = 4,num = 40})
    
    table.insert(self.gems,{id = 5,num = 99})
    table.insert(self.gems,{id = 6,num = 88})
end
