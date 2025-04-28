local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local NPCPlayers = Players:WaitForChild("NPCPlayers"):WaitForChild("Players")

local ESPFolder = {}
local lastESPUpdate = 0
local espUpdateInterval = 0.1 -- ESP Update ทุก 0.1 วินาที

-- ดึงตัวเอง
local function getCharacter(player)
    return player.Character
end

-- ดึงทีมของผู้เล่น หรือบอท
local function getTeam(player)
    if player:IsA("Player") then
        return player.Team and player.Team.Name
    elseif NPCPlayers:FindFirstChild(player.Name) then
        local npcData = NPCPlayers[player.Name]
        local team = npcData:FindFirstChild("_team")
        if team then
            return team.Value
        end
    end
    return nil
end

-- เช็กทีมเดียวกันไหม
local function isSameTeam(player)
    local myTeam = getTeam(LocalPlayer)
    local targetTeam = getTeam(player)
    return myTeam and targetTeam and myTeam == targetTeam
end

-- เช็กว่ามองเห็นไหม
local function isVisible(targetPart)
    if not targetPart then return false end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    params.FilterType = Enum.RaycastFilterType.Blacklist

    local rayResult = Workspace:Raycast(origin, direction, params)
    if rayResult then
        return rayResult.Instance:IsDescendantOf(targetPart.Parent)
    end
    return false
end

-- รวม Players + Bots
local function getAllCharacters()
    local targets = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = getCharacter(player)
            if char and char:FindFirstChild("Head") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                table.insert(targets, {Model = char, Player = player})
            end
        end
    end

    for _, npc in ipairs(NPCPlayers:GetChildren()) do
        local npcModel = Workspace:FindFirstChild(npc.Name)
        if npcModel and npcModel:FindFirstChild("Head") and npcModel:FindFirstChild("Humanoid") and npcModel.Humanoid.Health > 0 then
            table.insert(targets, {Model = npcModel, Player = npc})
        end
    end

    return targets
end

-- หาเป้าใกล้สุด
local function getClosestTarget()
    local closestTarget = nil
    local closestDistance = math.huge
    local allTargets = getAllCharacters()

    for _, data in ipairs(allTargets) do
        if not isSameTeam(data.Player) then
            local rootPart = data.Model:FindFirstChild("Head")
            if rootPart and isVisible(rootPart) then
                local distance = (Camera.CFrame.Position - rootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestTarget = rootPart
                end
            end
        end
    end

    return closestTarget
end

-- ESP
local function createESP(model)
    local box = Drawing.new("Square")
    box.Color = Color3.fromRGB(255, 0, 0)
    box.Thickness = 2
    box.Size = Vector2.new(50, 50)
    box.Filled = false
    box.Visible = false
    ESPFolder[model] = box
end

local function updateESP()
    local allTargets = getAllCharacters()

    for model, box in pairs(ESPFolder) do
        box.Visible = false
    end

    for _, data in ipairs(allTargets) do
        local rootPart = data.Model:FindFirstChild("HumanoidRootPart")
        if rootPart then
            if not ESPFolder[data.Model] then
                createESP(data.Model)
            end
            local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            if onScreen then
                local box = ESPFolder[data.Model]
                box.Size = Vector2.new(50, 50)
                box.Position = Vector2.new(screenPos.X - 25, screenPos.Y - 50)
                box.Visible = true
            end
        end
    end
end

-- Main Loop
RunService.RenderStepped:Connect(function(dt)
    -- Aimbot
    local targetPart = getClosestTarget()
    if targetPart then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
    end

    -- ESP
    lastESPUpdate = lastESPUpdate + dt
    if lastESPUpdate >= espUpdateInterval then
        lastESPUpdate = 0
        updateESP()
    end
end)
