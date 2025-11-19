--总表，管理MainPanel的所有属性
MainPanel = {}

--关联面板对象
MainPanel.panelObj = nil

--关联面板对应的控件
MainPanel.btnRole = nil
MainPanel.btnSkill = nil

--初始化MainPanel方法
function MainPanel:Init()
    --如果对象为空则实例化，反正不做任何操作
    if self.panelObj == nil then
        
        --实例化面板对象
        self.panelObj = ABMgr:LoadRes("ui","MainPanel",typeof(GameObject))
        
        --设置父对象为画布canvas
        self.panelObj.transform:SetParent(Canvas,false)

        --找到对应的控件，添加监听事件
        self.btnRole = self.panelObj.transform:Find("btnRole"):GetComponent(typeof(Button))

        --当添加函数监听时，如果直接：“.函数名” 传入自己的函数,那么在函数内部将无法用self获取内容，因为没有用:运算符，导致无法获得调用对象
        --所以我们只能使用一个匿名函数包裹我们需要订阅的函数
        self.btnRole.onClick:AddListener(function()
            self:ButtonRoleClick()
        end)
    end
end

function MainPanel:ButtonRoleClick()
    BagPanel:ShowMe()
    print("打开角色面板")
end

--显示面板
function MainPanel:ShowMe()
   self:Init()
   self.panelObj:SetActive(true)
    print("打开主面板")
end

--隐藏面板
function MainPanel:HideMe()
    self.panelObj:SetActive(false)
end