local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

local radius = 15 -- รัศมีวงกลม
local speed = 10 -- ความเร็วในการบินวน

spawn(function()
    while true do
        -- หาเป้าหมายที่ยังมีชีวิต
        local target = nil
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = player.Character
                if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    target = player
                    break
                end
            end
        end

        -- ถ้ามีเป้าหมาย
        if target then
            local angle = 0
            -- วนจนกว่าเป้าหมายจะตาย
            while target.Character and target.Character:FindFirstChild("Humanoid") and target.Character.Humanoid.Health > 0 do
                if target.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPos = target.Character.HumanoidRootPart.Position
                    angle = angle + speed * RunService.Heartbeat:Wait()
                    local x = math.cos(angle) * radius
                    local z = math.sin(angle) * radius
                    local hoverPos = Vector3.new(x, 25, z) + targetPos
                    HRP.CFrame = CFrame.new(hoverPos, targetPos) -- มองไปที่เป้าหมาย
                else
                    break
                end
            end
        end

        wait(0.5) -- เว้นจังหวะก่อนหาเป้าหมายใหม่
    end
end)
