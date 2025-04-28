local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local NPCPlayers = Players:WaitForChild("NPCPlayers"):WaitForChild("Players")

-- ESP System
local Drawing = Drawing
local ESP_Boxes = {}
local ESP_Enabled = true

-- Cache
local CachedTargets = {}

-- ตั้งค่าระยะสแกน
local UPDATE_INTERVAL = 0.1 -- สแกนทุก 0.1 วินาที

-- ตัวช่วย
local function getCharacter(player)
    return player.Character
end

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

local function isSameTeam(player)
    local myTeam = getTeam(LocalPlayer)
    local targetTeam = getTeam(player)
    return myTeam and targetTeam and myTeam == targetTeam
end

local function isVisible(targetPart)
    if not targetPart then return false end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin).Unit * 500

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    params.FilterType = Enum.RaycastFilterType.Blacklist

    local rayResult = Workspace:Raycast(origin, direction, params)
    if rayResult then
        return rayResult.Instance:IsDescendantOf(targetPart.Parent)
    end
    return false
end

-- หาเป้าหมายทุกๆ UPDATE_INTERVAL วินาที
task.spawn(function()
    while task.wait(UPDATE_INTERVAL) do
        CachedTargets = {}

        -- หา Player จริง
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = getCharacter(player)
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    if not isSameTeam(player) then
                        table.insert(CachedTargets, {Character = char, Player = player})
                    end
                end
            end
        end

        -- หา NPC Bot
        for _, npc in ipairs(NPCPlayers:GetChildren()) do
            local npcModel = Workspace:FindFirstChild(npc.Name)
            if npcModel and npcModel:FindFirstChild("HumanoidRootPart") and npcModel:FindFirstChild("Humanoid") and npcModel.Humanoid.Health > 0 then
                if not isSameTeam(npc) then
                    table.insert(CachedTargets, {Character = npcModel, Player = npc})
                end
            end
        end
    end
end)

-- Aimbot ทำงาน
RunService.RenderStepped:Connect(function()
    local closestTarget = nil
    local closestDistance = math.huge

    for _, data in ipairs(CachedTargets) do
        local char = data.Character
        local root = char:FindFirstChild("Head")
        if root and isVisible(root) then
            local distance = (Camera.CFrame.Position - root.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestTarget = root
            end
        end
    end

    if closestTarget then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
    end
end)

-- ESP วาดกล่อง
RunService.RenderStepped:Connect(function()
    if not ESP_Enabled then return end

    -- สร้างกล่องไว้ล่วงหน้า
    while #ESP_Boxes < 100 do
        local box = Drawing.new("Square")
        box.Visible = false
        box.Thickness = 2
        box.Filled = false
        box.Color = Color3.fromRGB(255, 0, 0)
        table.insert(ESP_Boxes, box)
    end

    -- ซ่อนทั้งหมด
    for _, box in ipairs(ESP_Boxes) do
        box.Visible = false
    end

    -- วาดเฉพาะเป้าหมายที่มีชีวิต
    local idx = 1
    for _, data in ipairs(CachedTargets) do
        local char = data.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
            if onScreen then
                local box = ESP_Boxes[idx]
                if box then
                    box.Size = Vector2.new(50, 50)
                    box.Position = Vector2.new(pos.X - 25, pos.Y - 50)
                    box.Visible = true
                    idx = idx + 1
                end
            end
        end
    end
end)
