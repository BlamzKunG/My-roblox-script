local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.RenderStepped:Connect(function()
    local myChar = LocalPlayer.Character
    if not myChar then return end

    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    -- ตำแหน่งเป้าหมาย: ด้านหน้าเรา 10 Studs และสูงขึ้นเล็กน้อย
    local basePos = myHRP.Position + myHRP.CFrame.LookVector * 10 + Vector3.new(0, 2, 0)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character

            -- วิธีที่ 1: ลากหัว (Hitbox)
            local head = char:FindFirstChild("Head")
            if head then
                head.CFrame = CFrame.new(basePos + Vector3.new(math.random(-3,3), math.random(-1,1), math.random(-3,3)))
                head.Velocity = Vector3.zero
                head.RotVelocity = Vector3.zero
            end

            -- วิธีที่ 2: ลาก HRP (เผื่อไว้)
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(basePos + Vector3.new(math.random(-2,2), 0, math.random(-2,2)))
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
            end

            -- วิธีที่ 3: ย่อขนาดร่างกาย เหลือแต่หัว
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "Head" then
                    part.Size = Vector3.new(0.1, 0.1, 0.1)
                    part.Transparency = 1
                    part.CanCollide = false
                end
            end

            -- วิธีที่ 4: หยุดทุก Animation และการเคลื่อนไหว
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
