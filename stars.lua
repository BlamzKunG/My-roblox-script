local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "BlamzKunG",
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
	Name = "ดึงโหด😈😈 (Bug)",
	CurrentValue = false,
	Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Tpall.lua"))()
    end,
        
})

Tab:CreateToggle({
	Name = "แช่คน",
	CurrentValue = false,
	Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/FrozenPlayer.lua"))()
    end,
})

Tab:CreateToggle({
	Name = "Esp",
	CurrentValue = false,
	Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Esp.lua"))()
    end,
        
})
