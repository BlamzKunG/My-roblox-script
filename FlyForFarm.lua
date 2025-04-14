local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function moveBelowMap()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    -- ล็อกตัวไว้
    hrp.Anchored = true

    -- ย้ายลงไปตำแหน่ง Y = -100 โดยยังอยู่ตำแหน่งเดิมในแนว X/Z
    local currentPos = hrp.Position
    hrp.CFrame = CFrame.new(currentPos.X, -100, currentPos.Z)
end

-- หากยังไม่มีตัวละคร ให้รอก่อน
if player.Character then
    moveBelowMap()
else
    player.CharacterAdded:Connect(function()
        moveBelowMap()
    end)
end
