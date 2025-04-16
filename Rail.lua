local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("Lxxuak Hub", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
local tab2 = DrRayLibrary.newTab("Auto Farm", "ImageIdHere")

tab.newToggle("Fast Attack", "Fast Attack", false, function(FastAttack)
    getgenv().FastAttack = FastAttack
    if FastAttack then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Fat"))()
    end
end)

tab.newButton("Button", "Prints Hello!", function(AutoFG)
    getgenv().FastAttack = AutoFG
    if AutoFG then
        
    end
end)
