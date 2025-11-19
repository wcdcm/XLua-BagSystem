--一个面板对应一个表
BagPanel = {}

--“成员变量”
BagPanel.panelObj = nil --面板对象

BagPanel.btnClose = nil --关闭按钮
BagPanel.togEquip = nil --装备Toggle
BagPanel.togItem = nil --物品Toggle
BagPanel.togGem = nil --宝石Toggle
BagPanel.svBag = nil --物品栏滚动条ScrollView
BagPanel.Content = nil --物品格子
BagPanel.items = {} --用来存储当前显示的格子
BagPanel.nowType = -1

--成员方法
function BagPanel:Init()
    if self.panelObj == nil then
        --实例化面板对象
        self.panelObj = ABMgr:LoadRes("ui", "BagPanel", typeof(GameObject))
        self.panelObj.transform:SetParent(Canvas, false)--设置父对象

        --获取按钮控件实例
        self.btnClose = self.panelObj.transform:Find("btnClose"):GetComponent(typeof(Button))

        --获取三个Toggle控件实例
        local group = self.panelObj.transform:Find("Group")
        self.togEquip = group:Find("togEquip"):GetComponent(typeof(Toggle))
        self.togItem = group:Find("togItem"):GetComponent(typeof(Toggle))
        self.togGem = group:Find("togGem"):GetComponent(typeof(Toggle))

        --获取ScrollView实例
        self.svBag = self.panelObj.transform:Find("svBag"):GetComponent(typeof(ScrollRect))
        self.Content = self.svBag.transform:Find("Viewport"):Find("Content")

        --添加关闭按钮监听
        self.btnClose.onClick:AddListener(function()
            self:HideMe()
        end)

        --添加单选框监听事件
        --注：Toggle对应的委托是UnityAction<bool>，这是系统委托，
        --我们现在要把lua的Function传给该委托就需要给此委托添加CSharpCallLua的特性
        --但由于它是系统委托，所以应该单独在C#代码中创建一个List来标记特性
        self.togEquip.onValueChanged:AddListener(function(val)
            if val == true then
                self:ChangeValue(1)
            end
        end)

        self.togItem.onValueChanged:AddListener(function(val)
            if val == true then
                self:ChangeValue(2)
            end
        end)

        self.togGem.onValueChanged:AddListener(function(val)
            if val == true then
                self:ChangeValue(3)
            end
        end)
    end
end


--显示面板
function BagPanel:ShowMe()
    self:Init()
    self.panelObj:SetActive(true)
    
    --第一次打开时更新一次数据
    if self.nowType == -1 then
        self:ChangeValue(1)
    end
    
end

--隐藏面板
function BagPanel:HideMe()
    self.panelObj:SetActive(false)
end

--Toggle逻辑处理，用来切页签
--type：1装备 2道具 3宝石
function BagPanel:ChangeValue(type)
    --进入函数之前先判断当前type是否等于传入的type,如果是，就直接返回，不执行下面的逻辑
    if self.nowType == type then
        return
    end
    
    self.nowType = type
    
    --切页，根据玩家信息来进行格子的创建
    --更新之前删除老的格子的信息 BagPanel.items
    --每次点击时,遍历items表，删除所有老的格子
    for i = 1, #self.items do
        self.items[i]:Destroy()
    end
    self.items = {}

    
    --再根据当前的格子创建新的格子 BagPanel.items
    --根据传入的type创建对应类型的格子
    local nowItems = nil
    if type == 1 then
        nowItems = PlayerData.equips
    elseif type == 2 then
        nowItems = PlayerData.items
    else
        nowItems = PlayerData.gems
    end

    --遍历nowItem创建格子
    for i = 1, #nowItems do
        --根据数据创建一个格子对象
        local grid = ItemGrid:new()
        
        --要实例化对象，设置位置
        grid:Init(self.Content,(i-1)%4 * 135,math.floor((i-1)/4) * 135)
        
        --初始化它的信息
        grid:InitData(nowItems[i])
        --把它存起来
        table.insert(self.items, grid)
    end
end