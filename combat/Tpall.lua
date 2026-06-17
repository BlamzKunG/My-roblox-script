local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.RenderStepped:Connect(function()
    local myChar = LocalPlayer.Character
    if not myChar then return end

    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    local basePos = myHRP.Position + myHRP.CFrame.LookVector * 10 + Vector3.new(0, 2, 0)
    local voidPos = Vector3.new(0, -1000, 0)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local head = char:FindFirstChild("Head")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hasBarrier = char:FindFirstChildOfClass("ForceField") -- เช็ก Barrier หลังเกิด

            if hrp and (not hum or hum.Health <= 0 or hasBarrier) then
                hrp.Anchored = true
                hrp.CFrame = CFrame.new(voidPos + Vector3.new(math.random(-5,5), 0, math.random(-5,5)))
                if head then
                    head.Anchored = true
                    head.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
                    head.Transparency = 1
                end
                continue
            end

            -- ปกติ: ตรึงไว้ด้านหน้า
            if hrp then
                hrp.Anchored = true
                hrp.CFrame = CFrame.new(basePos + Vector3.new(math.random(-2,2), 0, math.random(-2,2)))
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
            end

            if head then
                head.Anchored = true
                head.Size = Vector3.new(3, 8, 3)
                head.Transparency = 0.7
                head.CanCollide = false
                head.Material = Enum.Material.ForceField
                head.CFrame = CFrame.new(basePos + Vector3.new(math.random(-3,3), 1.5, math.random(-3,3)))
                head.Velocity = Vector3.zero
                head.RotVelocity = Vector3.zero
            end

            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "Head" then
                    part.Size = Vector3.new(0.1, 0.1, 0.1)
                    part.Transparency = 1
                    part.CanCollide = false
                    part.Anchored = true
                end
            end

            if hum then
                for _, anim in pairs(hum:GetPlayingAnimationTracks()) do
                    anim:AdjustSpeed(0)
                end
                hum.WalkSpeed = 0
                hum.JumpPower = 0
                hum.AutoRotate = false
            end
        end
    end
end)
