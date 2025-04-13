local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Rayfield Demo",
	LoadingTitle = "Rayfield UI",
	LoadingSubtitle = "by Sirius",
	ConfigurationSaving = {
		Enabled = false,
	},
	Discord = {
		Enabled = false,
	},
	KeySystem = false,
})

local Tab = Window:CreateTab("Main Tab", 4483362458) -- ชื่อแท็บ + ไอคอน (ImageId)
local Section = Tab:CreateSection("Main Controls")

Section:CreateButton({
	Name = "Click Me",
	Callback = function()
		print("Hello from Rayfield!")
	end,
})
