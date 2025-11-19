print("准备就绪!")

--初始化所有准备好的类别名
require("InitClass")

--初始化道具表信息
require("ItemData")

--初始化玩家信息
--1、单机游戏：本地获取 方式：PlayerPrefs、Json表
--2、网络游戏：从服务器获取
require("PlayerData")
PlayerData:Init()

--初始化主面板
require("MainPanel")

--初始化ItemGrid表
require("ItemGrid")

--初始化背包面板
require("BagPanel")


MainPanel:ShowMe()