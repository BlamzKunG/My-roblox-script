local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "BlamzKunG", HidePremium = false,IntroText = "BlamzKunG", SaveConfig = true, ConfigFolder = "OrionTest"})

local Main = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Oher = Window:MakeTab({
    Name = "Oher",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Main:AddButton({
    Name = "troll"

})

Main:AddTextbox({
    Name = "vtwi;jt",
    Defualt = "16",
    TextDisappear = true,
    Callback = function(Value)
		local Player = game.Players.localPlayer
        local chara = Player.Character
        chara.Humanoid.WalkSpeed = Value
	end 
    
})
