--面板基类BasePanel
Object:subClass("BasePanel")

--面板对象
BasePanel.panelObj = nil ---@class GameObject

--模拟一个字典，键为控件名，值为字典本身
BasePanel.controls = {}

--共有方法
function BasePanel:Init(panelName)
    if self.panelObj == nil then
        
        --实例化面板对象
        panelObj = ABMgr:LoadRes("ui", panelName, typeof(GameObject))
        self.panelObj.transform:SetParent(Canvas, false)

        --找控件
        --用GetComponentsInChildren(typeof(脚本名))找到某对象下挂载了某脚本的所有对象
        --所有的可交互控件的父类都是UIBehaviour，所以只需要写GetComponentsInChildren("UIBehaviour")
        local allControlsList = self.panelObj.transform:GetComponentsInChildren(typeof(UIBehaviour))
        
        --遍历这个allControlsList，因为它是C#对象所以需要按C#的规则来遍历
        --将controls的键自定义为每个控件脚本的名字，将controls的值设置为allControlsList中存储的控件脚本
        --为了避免找无用控件，我们定义一个规则，找控件时就按照这个规则来找：
        --Button：btn+名字
        --Toggle：tog+名字
        --Image：img+名字
        --ScrollRect：sv+名字
        for i = 0, allControlsList.Length - 1 do
            local controlsName = allControlsList[i].name
            --注意：遍历allControlsList得到的name是脚本所挂载的对象的名字，如果一个对象上挂载了多个脚本，那么就会出现冲突或覆盖的问题
            --按照名字的规则去找控件，必须满足命名规则 才能存起来
            if      string.find(controlsName, "btn") ~= nil or
                    string.find(controlsName, "tog") ~= nil or
                    string.find(controlsName, "img") ~= nil or
                    string.find(controlsName, "sv") ~= nil or
                    string.find(controlsName, "txt") ~= nil
            then
                --为了让我们在得到控件的时候确定控件的类型，我们需要将类型也获取到
                --利用反射的Type得到控件的类名
                local typeName = allControlsList[i]:GetType().Name
                --避免一个对象上出现多个UI控件，出现覆盖的问题
                --现在它们都会被存储到一个表中，避免不同的值所对应的键是同一个对象而产生的覆盖的问题
                
                --最终存储形式:
                --[[
                {
                btnRole = {Image = 控件对象，Button = 控件对象}，
                togItem = {Toggle = 控件对象}
                }
                --]]
                if self.controls[controlsName]~=nil then
                    --通过自定义索引的形式去添加一个新的成员变量
                    allControlsList[controlsName][typeName] = allControlsList[i]
                else
                    self.controls[controlsName] = { [typeName] = allControlsList[i]}
                end
            end
        end

    end
end

--得到控件:
function BasePanel:GetControls(controlName,typeName)
    if self.controls[controlName]~=nil then
       local sameNameControls = self.controls[controlName]
        
        if sameNameControls[typeName] ~= nil then
            return sameNameControls[typeName]
        end
    end
    
    return nil
end

function BasePanel:ShowMe()
    self:Init()
    self.panelObj:SetActive(true)
end

function BasePanel:HideMe()
    self.panelObj:SetActive(false)
end