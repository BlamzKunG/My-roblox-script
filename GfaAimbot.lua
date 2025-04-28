local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local NPCPlayers = Players:WaitForChild("NPCPlayers"):WaitForChild("Players")

-- ดึงตัวเอง
local function getCharacter(player)
    return player.Character
end

-- หาทีมของตัวละคร
local function getTeam(player)
    if NPCPlayers:FindFirstChild(player.Name) then
        local npcData = NPCPlayers[player.Name]
        local team = npcData:FindFirstChild("_team")
        if team then
            return team.Value
        end
    elseif player:IsA("Player") then
        return player.Team and player.Team.Name
    end
    return nil
end

-- เช็กว่าทีมเดียวกันไหม
local function isSameTeam(player)
    local myTeam = getTeam(LocalPlayer)
    local targetTeam = getTeam(player)
    return myTeam and targetTeam and myTeam == targetTeam
end

-- เช็กมุมมองระยะทางว่าหลังกำแพงไหม
local function isVisible(targetPart)
    if not targetPart then return false end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin).Unit * 1000

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    params.FilterType = Enum.RaycastFilterType.Blacklist

    local rayResult = Workspace:Raycast(origin, direction, params)
    if rayResult then
        return rayResult.Instance:IsDescendantOf(targetPart.Parent)
    end
    return false
end

-- หาเป้าที่ถูกต้อง
local function getClosestTarget()
    local closestTarget = nil
    local closestDistance = math.huge

    -- รวม Player จริงกับ Bot
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = getCharacter(player)
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                if char.Humanoid.Health > 0 and not isSameTeam(player) and isVisible(char.HumanoidRootPart) then
                    local distance = (Camera.CFrame.Position - char.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestTarget = char
                    end
                end
            end
        end
    end

    -- รวม Bot ด้วย
    for _, npc in ipairs(NPCPlayers:GetChildren()) do
        local npcModel = Workspace:FindFirstChild(npc.Name) or getNil(npc.Name, "Model")
        if npcModel and npcModel:FindFirstChild("HumanoidRootPart") and npcModel:FindFirstChild("Humanoid") then
            if npcModel.Humanoid.Health > 0 and not isSameTeam(npc) and isVisible(npcModel.HumanoidRootPart) then
                local distance = (Camera.CFrame.Position - npcModel.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestTarget = npcModel
                end
            end
        end
    end

    return closestTarget
end

-- Aimbot เล็ง
RunService.RenderStepped:Connect(function()
    local target = getClosestTarget()
    if target then
        local aimPart = target:FindFirstChild("Head")
        if aimPart then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPart.Position)
        end
    end
end)

-- ESP Box (ตัวอย่างง่าย ๆ)
local Drawing = Drawing or nil
local ESP = {}

RunService.RenderStepped:Connect(function()
    -- ล้าง ESP เก่า
    for _, box in ipairs(ESP) do
        box.Visible = false
    end
    table.clear(ESP)

    -- วาด ESP ใหม่
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = getCharacter(player)
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                local screenPos, onScreen = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
                if onScreen then
                    local box = Drawing.new("Square")
                    box.Size = Vector2.new(50, 50)
                    box.Position = Vector2.new(screenPos.X - 25, screenPos.Y - 50)
                    box.Color = Color3.fromRGB(255, 0, 0)
                    box.Thickness = 2
                    box.Filled = false
                    box.Visible = true
                    table.insert(ESP, box)
                end
            end
        end
    end
end)
