local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

-- CONFIG
local FOV_RADIUS = 150
local SMOOTHNESS_NORMAL = 0.15 -- ตอนปกติ
local SMOOTHNESS_AIMING = 0.04 -- ตอนยิง
local SMOOTHNESS_MOVING = 0.3  -- ตอนขยับเมาส์
local SMOOTHNESS = SMOOTHNESS_NORMAL

-- Drawing Setup
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.NumSides = 64
FOVCircle.Radius = FOV_RADIUS
FOVCircle.Color = Color3.fromRGB(255, 255, 0)
FOVCircle.Filled = false
FOVCircle.Visible = true

local ESPBoxes = {}

-- Internal
local lastMousePos = UserInputService:GetMouseLocation()
local lastMoveTime = tick()
local movingCooldown = 0.1
local isShooting = false

-- Utility
local function isVisible(position, targetCharacter)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local direction = (position - Camera.CFrame.Position).Unit * 500
    local ray = workspace:Raycast(Camera.CFrame.Position, direction, rayParams)
    if ray then
        return ray.Instance and ray.Instance:IsDescendantOf(targetCharacter)
    end
    return true
end

local function getBestTarget()
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local candidates = {}

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            if humanoid.Health > 0 then
                local hrp = player.Character.HumanoidRootPart
                local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local distFromCenter = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if distFromCenter <= FOV_RADIUS and isVisible(hrp.Position, player.Character) then
                        table.insert(candidates, {player = player, distance = distFromCenter, health = humanoid.Health})
                    end
                end
            end
        end
    end

    -- เลือกตัวที่ใกล้ที่สุดก่อน แล้วในตัวใกล้นั้น เอา HP น้อยที่สุด
    table.sort(candidates, function(a, b)
        if math.abs(a.distance - b.distance) <= 5 then
            return a.health < b.health
        else
            return a.distance < b.distance
        end
    end)

    if #candidates > 0 then
        return candidates[1].player
    else
        return nil
    end
end

-- Detect Shooting
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isShooting = true
    end
end)

UserInputService.InputEnded:Connect(function(input, processed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isShooting = false
    end
end)

-- Main Loop
RunService.RenderStepped:Connect(function()
    -- Update FOV
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Position = screenCenter

    -- Detect Mouse Move
    local mousePos = UserInputService:GetMouseLocation()
    if (mousePos - lastMousePos).Magnitude > 2 then
        lastMoveTime = tick()
    end
    lastMousePos = mousePos

    -- Adjust Smoothness
    if isShooting then
        SMOOTHNESS = SMOOTHNESS_AIMING
    elseif tick() - lastMoveTime < movingCooldown then
        SMOOTHNESS = SMOOTHNESS_MOVING
    else
        SMOOTHNESS = SMOOTHNESS_NORMAL
    end

    -- Aimbot Logic
    local target = getBestTarget()
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local aimPos = target.Character.HumanoidRootPart.Position
        local currentPos = Camera.CFrame.Position
        local newCF = CFrame.new(currentPos, aimPos)
        Camera.CFrame = Camera.CFrame:Lerp(newCF, SMOOTHNESS)
    end

    -- Clear old ESP
    for _, box in pairs(ESPBoxes) do
        box.Visible = false
        box:Remove()
    end
    table.clear(ESPBoxes)

    -- Draw ESP
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("HumanoidRootPart") then
            local head = player.Character.Head
            local hrp = player.Character.HumanoidRootPart
            local headPos, onHead = Camera:WorldToViewportPoint(head.Position)
            local footPos, onFoot = Camera:WorldToViewportPoint(hrp.Position)
            if onHead and onFoot then
                local height = math.abs(footPos.Y - headPos.Y)
                local width = height / 2
                local box = Drawing.new("Square")
                box.Size = Vector2.new(width, height)
                box.Position = Vector2.new(headPos.X - width / 2, headPos.Y)
                box.Color = Color3.fromRGB(0, 255, 0)
                box.Thickness = 1
                box.Filled = false
                box.Visible = true
                table.insert(ESPBoxes, box)
            end
        end
    end
end)
