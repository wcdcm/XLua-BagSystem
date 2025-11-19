--生成了一个表ItemGrid，这个表继承自Object
Object:subClass("ItemGrid")

--成员变量:
ItemGrid.obj = nil
ItemGrid.imgIcon = nil
ItemGrid.Text = nil

--函数:
--实例化格子对象
function ItemGrid:Init(father,posX,posY)
    self.obj = ABMgr:LoadRes("ui", "ItemGrid")

    --设置父对象
    self.obj.transform:SetParent(father, false)

    --设置格子位置
    --self.obj.transform.localPosition = Vector3((i - 1) % 4 * 135, math.floor((i - 1) / 4) * 135, 0)
    self.obj.transform.localPosition = Vector3(posX, posY, 0)

    --找到格子控件
    self.imgIcon = self.obj.transform:Find("imgIcon"):GetComponent(typeof(Image))
    self.Text = self.obj.transform:Find("txtNumber"):GetComponent(typeof(Text))
end

--初始化格子信息
--data是外部传入的 道具信息 里面包含了 id和num
function ItemGrid:InitData(nowItems)
    --设置图标数据
    --通过道具id去读取道具配置表，得到 图标信息
    local data = ItemData[nowItems.id]
    --根据图标名加载图集，再加载图集中的图标信息
    --string.split的作用：将一个输入字符串按照指定的分隔符（delimiter）拆分成多个子串，最终返回包含所有子串的数组（table）。
    local strs = string.split(data.icon, "_")
    --加载图集
    local spriteAtlas = ABMgr:LoadRes("ui", strs[1], typeof(SpriteAtlas))
    --加载图标
    self.imgIcon.sprite = spriteAtlas:GetSprite(strs[2])
    --设置数量数据
    self.Text.text = nowItems.num
end

--其他逻辑
--销毁对象:
function ItemGrid:Destroy()
    GameObject.Destroy(self.obj)
    self.obj = nil
end

