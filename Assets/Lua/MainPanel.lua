--总表，管理MainPanel的所有属性
BasePanel:subClass("MainPanel")


--初始化MainPanel方法
function MainPanel:Init(panelName)
    --先调用父对象的Init方法
    self.base.Init(self,panelName)

    print(self:GetControls("btnRole","Image"))
    if self.isInitEvent == false then
        --当添加函数监听时，如果直接：“.函数名” 传入自己的函数,那么在函数内部将无法用self获取内容，因为没有用:运算符，导致无法获得调用对象
        --所以我们只能使用一个匿名函数包裹我们需要订阅的函数
        self:GetControls("btnRole","Button").onClick:AddListener(function()
            self:ButtonRoleClick()
        end)
        self.isInitEvent = true
    end
    
end

function MainPanel:ButtonRoleClick()
    BagPanel:ShowMe("BagPanel")
    print("打开角色面板")
end
