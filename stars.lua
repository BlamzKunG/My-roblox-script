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
        local RunService = game:GetService("RunService")
        local LocalPlayer = game.Players.LocalPlayer
    
        RunService.RenderStepped:Connect(function()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local character = player.Character
                    if character and character:FindFirstChild("Head") then
                        local head = character.Head
                        head.Size = Vector3.new(10, 10, 10)
                        head.Transparency = 1
                        head.CanCollide = false
    
                        local mesh = head:FindFirstChildOfClass("SpecialMesh")
                        if mesh then mesh:Destroy() end
                    end
                end
            end
        end)
    end,
    
})

Tab:CreateToggle({
	Name = "วาร์ปไปยิง",
	CurrentValue = false,
	Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        spawn(function()
            while true do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local character = player.Character
                        if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                            if character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                -- วาร์ปห่างจากเป้าหมาย 3 studs ด้านหลัง
                                local targetPos = character.HumanoidRootPart.Position
                                local offset = Vector3.new(0, 0, -3) -- หรือเปลี่ยนเป็น Vector3.new(0, 5, 0) เพื่ออยู่บนหัว
                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + offset)
                                wait(2) -- รอ 1 วิ ก่อน TP ไปหาคนต่อไป
                            end
                        end
                    end
                end
                wait(0.5) -- ป้องกันแครช / ลดโหลด
            end
        end)
    end,
        
})

Tab:CreateToggle({
	Name = "Esp",
	CurrentValue = false,
	Callback = function(Value)
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
    end,
        
})
