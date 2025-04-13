local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.RenderStepped:Connect(function()
    local myChar = LocalPlayer.Character
    if not myChar then return end

    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    local basePos = myHRP.Position + myHRP.CFrame.LookVector * 5 + Vector3.new(0, 2, 0)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character

            -- หาเป้าหมายหลักเป็นหัว (Hitbox สำคัญ)
            local head = char:FindFirstChild("Head")
            if head then
                -- วิธีที่ 1: ลากด้วย CFrame
                head.CFrame = CFrame.new(basePos + Vector3.new(math.random(-2,2), math.random(-1,1), math.random(-2,2)))

                -- วิธีที่ 2: เคลียร์ velocity ให้หยุดนิ่ง
                head.Velocity = Vector3.zero
                head.RotVelocity = Vector3.zero
            end

            -- วิธีที่ 3: ย้าย HumanoidRootPart (สำรองถ้า Head ไม่ถูกต้อง)
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(basePos + Vector3.new(math.random(-1,1), 0, math.random(-1,1)))
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
            end

            -- วิธีที่ 4: ลดขนาด Body ให้เหลือแต่หัว (แถม!)
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "Head" then
                    part.Size = Vector3.new(0.1, 0.1, 0.1)
                    part.Transparency = 1
                    part.CanCollide = false
                end
            end

            -- วิธีที่ 5: หยุด Animation สำหรับความนิ่งขั้นสุด
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
