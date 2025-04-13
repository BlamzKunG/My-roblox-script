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
