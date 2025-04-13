local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local frozenPlayers = {}

local function freezePlayer(player)
    if player == LocalPlayer then return end
    local char = player.Character
    if not char then return end

    -- Freeze movement
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        if not frozenPlayers[player] then
            frozenPlayers[player] = hrp.CFrame
        end
        hrp.CFrame = frozenPlayers[player]
        hrp.Velocity = Vector3.zero
        hrp.RotVelocity = Vector3.zero
    end

    -- Freeze humanoid
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = 0
        hum.JumpPower = 0
        hum.AutoRotate = false
        -- Stop animations
        for _, track in pairs(hum:GetPlayingAnimationTracks()) do
            track:AdjustSpeed(0)
        end
    end

    -- Freeze body parts
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Velocity = Vector3.zero
            part.RotVelocity = Vector3.zero
        end
    end
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            freezePlayer(player)
        end
    end
end)
