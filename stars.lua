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

Tab:CreateButton({
	Name = "Click Me",
	Callback = function()
		print("Hello from Rayfield!")
	end,
})

Tab:CreateToggle({
	Name = "God Mode",
	CurrentValue = false,
	Callback = function(Value)
		print("God Mode:", Value)
	end,
})
