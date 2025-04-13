local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.RenderStepped:Connect(function()
    local myChar = LocalPlayer.Character
    if not myChar then return end

    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    local basePos = myHRP.Position
    local direction = myHRP.CFrame.LookVector.Unit
    local baseOffset = direction * 10 -- << เพิ่มระยะห่างจาก 5 เป็น 10 studs

    for i, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character

            -- ย้าย Head
            local head = char:FindFirstChild("Head")
            if head then
                local spread = Vector3.new(math.cos(i) * 4, math.sin(i * 2) * 2, math.sin(i) * 4)
                head.CFrame = CFrame.new(basePos + baseOffset + spread)
                head.Velocity = Vector3.zero
                head.RotVelocity = Vector3.zero
            end

            -- สำรองด้วย HRP
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local spread = Vector3.new(math.cos(i) * 4, 0, math.sin(i) * 4)
                hrp.CFrame = CFrame.new(basePos + baseOffset + spread)
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
            end

            -- ลดขนาดชิ้นส่วนร่างกายที่ไม่ใช่หัว
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "Head" then
                    part.Size = Vector3.new(0.1, 0.1, 0.1)
                    part.Transparency = 1
                    part.CanCollide = false
                end
            end

            -- หยุด animation
            local hum = char:FindFirstChildOfClass("Humanoid")
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
