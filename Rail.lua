local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:CreateWindow("PvH Control Panel", "By Blamz")
local MainTab = Library:CreateTab("Main")
local ControlSection = MainTab:CreateSection("Controls")

ControlSection:CreateButton("Click Me", function()
    print("Button was clicked!")
end)

ControlSection:CreateToggle("God Mode", false, function(state)
    print("God Mode:", state)
end)
