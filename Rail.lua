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

tab2.newToggle("AutoClaim", "AutoClaim", false, function(AutoClaim)
    getgenv().HeroFA = AutoClaim
    if AutoClaim then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Autocli.lua"))()
    end
end)

tab2.newButton("Auto Fuse to Gold", "Auto Fuse OP", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Atf.lua"))()
end)

tab2.newButton("Auto Fuse to Rainbow", "Auto Fuse OP", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Afr.lua"))()
end)
