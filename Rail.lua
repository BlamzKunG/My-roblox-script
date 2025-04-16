local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:NewWindow("Star Rail Simulator")

local Tab = Window:NewSection("My Tab")

Tab:CreateButton("Button", function()

print("hello")

end)
