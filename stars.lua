local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "PvH Control Panel",
    LoadingTitle = "Initializing",
    LoadingSubtitle = "Loading UI...",
    ConfigurationSaving = {
        Enabled = false,
    }
})

local Tab = Window:CreateTab("Main")

Tab:CreateToggle({
    Name = "หัวใหญ่",
    Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/HitboxExpand.lua"))()	
    end,    
})

Tab:CreateToggle({
	Name = "ดึงโหด😈😈 (ปิดใช้งาน)",
	CurrentValue = false,
	Callback = function(Value)
                
    end,
        
})

Tab:CreateToggle({
	Name = "Esp",
	CurrentValue = false,
	Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Esp.lua"))()
    end,
        
})
