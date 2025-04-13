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
   loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/HitboxExpand.lua"))()	
    end,    
})

Tab:CreateToggle({
	Name = "ดึงโหด😈😈 (BUG)",
	CurrentValue = false,
	Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        spawn(function()
            while true do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local targetChar = player.Character
                        local myChar = LocalPlayer.Character
        
                        if targetChar and myChar and
                           targetChar:FindFirstChild("Humanoid") and targetChar.Humanoid.Health > 0 and
                           targetChar:FindFirstChild("HumanoidRootPart") and
                           myChar:FindFirstChild("HumanoidRootPart") then
        
                            local targetHRP = targetChar.HumanoidRootPart
                            local myHRP = myChar.HumanoidRootPart
        
                            local distance = (targetHRP.Position - myHRP.Position).Magnitude
        
                            -- ถ้าห่างเกิน 10 studs ค่อยดึง (เพื่อความแนบเนียน)
                            if distance > 100 then
                                local direction = (myHRP.Position - targetHRP.Position).Unit
                                local step = direction * 1 -- ดึงทีละน้อย ๆ 1 stud
                                targetHRP.CFrame = targetHRP.CFrame + step
                            end
        
                            wait(0.1) -- ดึงเรื่อย ๆ อย่างนุ่มนวล
                        end
                    end
                end
                wait(0.1)
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
