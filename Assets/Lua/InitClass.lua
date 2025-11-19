--加载必要脚本
require("Object")--面向对象相关
require("SplitTools")--拆分字符串
Json = require("JsonUtility")--Json解析

--处理unity常用类的别名
GameObject = CS.UnityEngine.GameObject
Resources = CS.UnityEngine.Resources
Transform = CS.UnityEngine.Transform
RectTransform = CS.UnityEngine.RectTransform
TextAsset = CS.UnityEngine.TextAsset
UIBehaviour = CS.UnityEngine.EventSystems.UIBehaviour

--图集相关的类
SpriteAtlas = CS.UnityEngine.U2D.SpriteAtlas

Vector3 = CS.UnityEngine.Vector3
Vector2 = CS.UnityEngine.Vector2

--UI相关
UI = CS.UnityEngine.UI
Image = UI.Image
Text = UI.Text
Button = UI.Button
Toggle = UI.Toggle
ScrollRect = UI.ScrollRect
--找到对应的Canvas，一次加载多处使用
Canvas = GameObject.Find("Canvas").transform


--自定义的类
ABMgr = CS.ABMgr.GetInstance()

