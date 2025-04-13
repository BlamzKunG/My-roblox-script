local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()


local Window = Rayfield:CreateWindow({
    Name = "PvH Control Panel",
    LoadingTitle = "Initializing",
    LoadingSubtitle = "Loading UI...",
    ConfigurationSaving = {
        Enabled = false,
    }
})

local Tab = Window:CreateTab("Main Tab", 4483362458)
local Section = Tab:CreateSection("Main Controls")

Section:CreateButton({
	Name = "Click Me",
	Callback = function()
		print("Hello from Rayfield!")
	end,
})
