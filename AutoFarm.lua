local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "เรื้อนดินน้ำมัน(Auto Farm)🥵",
    LoadingTitle = "🤓☝🏻",
    LoadingSubtitle = "กำลังดาวน์โหลด...",
    ConfigurationSaving = {
    Enabled = true,
    }
})

local Tab = Window:CreateTab("Main")

Tab:CreateToggle({
        Name = "Auto Farm",
        Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Tpall.lua"))()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/FlyForFarm.lua"))()
      	loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/AutoClick.lua"))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/AutoRejoin.lua"))()
    end,    
})
