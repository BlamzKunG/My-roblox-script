loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Cr.lua"))()
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("TikTok:Lxxuak", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")

--loadstring(game:HttpGet(""))()

tab.newToggle("Kill All", "โอกาศโดนเตะน้อยมาก", false, function(all)
    getgenv().FastAttack = all
    if all then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Ka1t.lua"))()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Cr.lua"))()
    end
end)

tab.newToggle("Kill All lnw", "โอกาศโดนเตะสูง", false, function(alll)
    getgenv().FastAttack = alll
    if alll then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/KA.lua"))()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Cr.lua"))()
    end
end)
