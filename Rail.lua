local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("Lxxuak Hub", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
local tab2 = DrRayLibrary.newTab("Auto Farm", "ImageIdHere")

--loadstring(game:HttpGet(""))()

tab.newToggle("Fast Attack", "Fast Attack", false, function(FastAttack)
    getgenv().FastAttack = FastAttack
    if FastAttack then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Fat"))()
    end
end)

tab.newToggle("Hero Fast Attack", "Hero Fast Attack", false, function(HeroFA)
    getgenv().HeroFA = HeroFA
    if HeroFA then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/HeroFA.lua"))()
    end
end)

tab.newToggle("Auto Rebirth", "AutoRebirth", false, function(AutoRebirth)
    getgenv().AutoRebirth = AutoRebirth
    if AutoRebirth then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/AutoRebirth.lua"))()
    end
end)

tab2.newToggle("AutoClaim", "AutoClaim", false, function(AutoClaim)
    getgenv().AutoClaim = AutoClaim
    if AutoClaim then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Autocli.lua"))()
    end
end)

tab2.newToggle("Auto Spin UGC", "Auto Spin UGC", false, function(AutoUGCSpin)
    getgenv().AutoUGCSpin = AutoUGCSpin
    if AutoUGCSpin then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/AutoUGCSpin.lua"))()
    end
end)

tab2.newToggle("Auto Hatch", "Auto Hatch Herta space only", false, function(AutoHatch)
    getgenv().AutoHatch = AutoHatch
    if AutoHatch then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/AutoHatch.lua"))()
    end
end)

tab2.newButton("Auto Fuse to Gold", "Auto Fuse OP", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Atf.lua"))()
end)

tab2.newButton("Auto Fuse to Rainbow", "Auto Fuse OP", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Afr.lua"))()
end)


