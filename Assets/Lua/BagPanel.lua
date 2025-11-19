BasePanel:subClass("BagPanel")

--“成员变量”
BagPanel.Content = nil --物品格子
BagPanel.items = {} --用来存储当前显示的格子
BagPanel.nowType = -1

--成员方法
function BagPanel:Init(panelName)
    self.base.Init(self,panelName)

    if self.isInitEvent == false then
        
        --找到没有挂载UI控件的对象，还是需要手动去找
        self.Content = self:GetControls("svBag","ScrollRect").transform:Find("Viewport"):Find("Content")
        
        --添加关闭按钮监听
        self:GetControls("btnClose","Button").onClick:AddListener(function()
            self:HideMe()
        end)

        --添加单选框监听事件
        --注：Toggle对应的委托是UnityAction<bool>，这是系统委托，
        --我们现在要把lua的Function传给该委托就需要给此委托添加CSharpCallLua的特性
        --但由于它是系统委托，所以应该单独在C#代码中创建一个List来标记特性
        self:GetControls("togEquip","Toggle").onValueChanged:AddListener(function(val)
            if val == true then
                self:ChangeValue(1)
            end
        end)

        self:GetControls("togItem","Toggle").onValueChanged:AddListener(function(val)
            if val == true then
                self:ChangeValue(2)
            end
        end)

        self:GetControls("togGem","Toggle").onValueChanged:AddListener(function(val)
            if val == true then
                self:ChangeValue(3)
            end
        end)
        
        self.isInitEvent = true
    end
end


--显示面板(override)
function BagPanel:ShowMe(panelName)
    self.base.ShowMe(self,panelName)

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
        grid:Init(self.Content, (i - 1) % 4 * 135, math.floor((i - 1) / 4) * 135)

        --初始化它的信息
        grid:InitData(nowItems[i])
        --把它存起来
        table.insert(self.items, grid)
    end
end