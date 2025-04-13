local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "PvH Control Panel",
    LoadingTitle = "Initializing",
    LoadingSubtitle = "Loading UI...",
    ConfigurationSaving = {
        Enabled = false,
    }
})

local Tab = Window:CreateTab("Main")
local Section = Tab:CreateSection("Controls")

Section:CreateButton({
    Name = "Kill All",
    Callback = function()
        print("Killed All Players")
    end,
})

Section:CreateToggle({
    Name = "God Mode",
    CurrentValue = false,
    Callback = function(Value)
        print("God Mode: ", Value)
    end,
})
