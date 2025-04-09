local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "BlamzKunG", HidePremium = false,IntroText = "BlamzKunG", SaveConfig = true, ConfigFolder = "OrionTest"})

local Combat = Window:MakeTab({
    Name = "Combat",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Chest = Window:MakeTab({
    Name = "Chest",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Combat:AddButton({
    Name = "Fast Attack"
})
