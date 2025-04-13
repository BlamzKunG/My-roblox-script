local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "เรื้อนดินน้ำมัน🥵",
    LoadingTitle = "🤓☝🏻",
    LoadingSubtitle = "กำลังดาวน์โหลด...",
    ConfigurationSaving = {
    Enabled = false,
    }
})

local Tab = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("Esp")
local Tab3 = Window:CreateTab("Oher")

Tab:CreateToggle({
        Name = "หัวใหญ่",
        Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/HitboxExpand.lua"))()	
    end,    
})

Tab:CreateToggle({
        Name = "หัวใหญ่ (เนียนๆมั้ง)",
	CurrentValue = false,
        Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/HitboxExpand-Mini.lua"))()	
    end,    
})

Tab:CreateToggle({
        Name = "ดึงโหด😈😈",
        CurrentValue = false,
        Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Tpall.lua"))()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Hitboxfortpkill.lua"))()
    end,        
})

Tab:CreateToggle({
	Name = "บินเกาะหัว",
	CurrentValue = false,
	Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Hitboxfortpkill.lua"))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Tpkill.lua"))()
    end,
})

Tab:CreateToggle({
	Name = "กระสุนแม่เหล็ก",
	CurrentValue = false,
	Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/MagneticBullets.lua"))()
    end,
        
})

Tab2:CreateToggle({
	Name = "Esp",
	CurrentValue = false,
	Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Esp.lua"))()
    end,
        
})

Tab3:CreateToggle({
	Name = "Reset Script",
	CurrentValue = false,
	Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Reset.lua"))()
    end,
        
})
