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
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local character = player.Character
                if character and character:FindFirstChild("Head") then
                    character.Head.Size = Vector3.new(10, 10, 10)
                    character.Head.Transparency = 1 -- มองไม่เห็น
                    character.Head.CanCollide = false
                end
            end
        end
        
            wait(1) -- ต้องมี wait ไม่งั้นแครช
        end,
})

Tab:CreateToggle({
	Name = "วาร์ปไปยิง",
	CurrentValue = false,
	Callback = function(Value)
		print("God Mode:", Value)
	end,
})

Tab:CreateToggle({
	Name = "Esp",
	CurrentValue = false,
	Callback = function(Value)
		print("God Mode:", Value)
	end,
})
