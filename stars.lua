local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "BlamzKunG", HidePremium = false,IntroText = "BlamzKunG", SaveConfig = true, ConfigFolder = "OrionTest"})

local Main = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Oher = Window:MakeTab({
    Name = "Oher",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Main:AddButton({
    Name = "hit",
    Callback = function()
        while true do

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
            end
})

Main:AddButton({
    Name = "esp",
    Callback = function()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

for _, player in pairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "ESP"
        BillboardGui.Size = UDim2.new(0, 100, 0, 40)
        BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        BillboardGui.AlwaysOnTop = true

        local NameTag = Instance.new("TextLabel")
        NameTag.Text = player.Name
        NameTag.BackgroundTransparency = 1
        NameTag.TextColor3 = Color3.new(1, 0, 0)
        NameTag.Size = UDim2.new(1, 0, 1, 0)
        NameTag.Parent = BillboardGui

        player.CharacterAdded:Connect(function(char)
            repeat wait() until char:FindFirstChild("Head")
            BillboardGui:Clone().Parent = char.Head
        end)

        if player.Character and player.Character:FindFirstChild("Head") then
            BillboardGui:Clone().Parent = player.Character.Head
        end
    end
end

				
})
