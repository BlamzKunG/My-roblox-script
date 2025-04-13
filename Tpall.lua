local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.RenderStepped:Connect(function()
        if head then
    head.Anchored = true
    head.Size = Vector3.new(8, 8, 8) -- ขยายขนาดหัวแบบพอเหมาะ
    head.Transparency = 0.7         -- เห็นราง ๆ พอเล็ง
    head.CanCollide = false
    head.Material = Enum.Material.ForceField -- ดูเหมือนเอฟเฟกต์พิเศษ
    head.CFrame = CFrame.new(basePos + Vector3.new(math.random(-3,3), 1.5, math.random(-3,3)))
    head.Velocity = Vector3.zero
    head.RotVelocity = Vector3.zero
        end
    local myChar = LocalPlayer.Character
    if not myChar then return end

    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    -- จุดที่จะลากผู้เล่นมาค้างไว้
    local basePos = myHRP.Position + myHRP.CFrame.LookVector * 10 + Vector3.new(0, 2, 0)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character

            local head = char:FindFirstChild("Head")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")

            -- หยุดฟิสิกส์และเอาความเป็นเจ้าของ network กลับ
            if hrp then
                hrp.Anchored = true -- ล็อกไม่ให้ขยับ
                hrp.CFrame = CFrame.new(basePos + Vector3.new(math.random(-2,2), 0, math.random(-2,2)))
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
            end

            if head then
                head.Anchored = true
                head.CFrame = CFrame.new(basePos + Vector3.new(math.random(-3,3), 1.5, math.random(-3,3)))
                head.Velocity = Vector3.zero
                head.RotVelocity = Vector3.zero
            end

            -- ย่อทุกอย่าง ยกเว้นหัว และซ่อนไว้
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "Head" then
                    part.Size = Vector3.new(0.1, 0.1, 0.1)
                    part.Transparency = 1
                    part.CanCollide = false
                    part.Anchored = true
                end
            end

            -- หยุดการเคลื่อนไหว / animation / หมุนตัว
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
