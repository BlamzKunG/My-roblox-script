local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("Lxxuak Hub", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
local tab2 = DrRayLibrary.newTab("Auto Farm", "ImageIdHere")

tab.newToggle("Fast Attack", "Fast Attack", false, function(toggleState)
    getgenv().FastAttack = toggleState
    if toggleState then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Fat"))()
    end
end)

tab2.newToggle("Auto Farm", "Auto Farm", false, function(toggleState)
    if toggleState then
        print("On")
    else
        print("Off")
    end
end)
