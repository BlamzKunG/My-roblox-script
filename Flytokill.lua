local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local myChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local myHRP = myChar:WaitForChild("HumanoidRootPart")

local targetPlayer = nil
local playerList = {}
local targetIndex = 0
local switchCooldown = 1
local lastSwitchTime = 0

-- อัปเดตรายชื่อผู้เล่นที่มีชีวิต
local function updatePlayerList()
    playerList = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
            if p.Character.Humanoid.Health > 0 then
                table.insert(playerList, p)
            end
        end
    end
end

-- เปลี่ยนเป้าหมายไปยังผู้เล่นคนถัดไป
local function switchTarget()
    updatePlayerList()
    if #playerList == 0 then
        targetPlayer = nil
        return
    end
    targetIndex = (targetIndex % #playerList) + 1
    targetPlayer = playerList[targetIndex]
end

-- ลอยบนหัวเป้าหมาย
RunService.RenderStepped:Connect(function()
    if not myHRP then return end

    -- ตรวจสอบเป้าหมายว่ายังอยู่หรือไม่
    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Humanoid") or targetPlayer.Character.Humanoid.Health <= 0 then
        if tick() - lastSwitchTime > switchCooldown then
            lastSwitchTime = tick()
            switchTarget()
        end
        return
    end

    local targetHead = targetPlayer.Character:FindFirstChild("Head")
    if not targetHead then return end

    local desiredPos = targetHead.Position + Vector3.new(0, 2.5, 0)
    local currentPos = myHRP.Position
    local newPos = currentPos:Lerp(desiredPos, 0.08)

    myHRP.Velocity = Vector3.zero
    myHRP.RotVelocity = Vector3.zero
    myHRP.CFrame = CFrame.new(newPos)
end)
