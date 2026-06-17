local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local espData = {}

-- ฟังก์ชันสร้างกล่องและ HP bar
local function createESP()
    local box = Drawing.new("Square")
    box.Color = Color3.fromRGB(0, 255, 0)
    box.Thickness = 2
    box.Filled = false
    box.Visible = false

    local hpBar = Drawing.new("Line")
    hpBar.Color = Color3.fromRGB(255, 0, 0)
    hpBar.Thickness = 2
    hpBar.Visible = false

    return {
        Box = box,
        HP = hpBar
    }
end

local function setupESP(player)
    if player == LocalPlayer then return end
    espData[player] = createESP()
end

local function removeESP(player)
    if espData[player] then
        espData[player].Box:Remove()
        espData[player].HP:Remove()
        espData[player] = nil
    end
end

-- ตั้งค่าเริ่มต้น
for _, player in ipairs(Players:GetPlayers()) do
    setupESP(player)
end

-- สำหรับผู้เล่นใหม่
Players.PlayerAdded:Connect(setupESP)
Players.PlayerRemoving:Connect(removeESP)

RunService.RenderStepped:Connect(function()
    for player, drawings in pairs(espData) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and hum and hum.Health > 0 then
            local rootPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            local head = char:FindFirstChild("Head")
            local leg = char:FindFirstChild("LeftFoot") or char:FindFirstChild("Left Leg")

            if head and leg then
                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.3, 0))
                local legPos = Camera:WorldToViewportPoint(leg.Position - Vector3.new(0, 0.3, 0))

                local height = (legPos.Y - headPos.Y)
                local width = height / 2.5

                local box = drawings.Box
                box.Size = Vector2.new(width, height)
                box.Position = Vector2.new(rootPos.X - width/2, headPos.Y)
                box.Visible = onScreen

                -- HP bar ข้างกล่อง
                local hp = drawings.HP
                local hpPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                local barHeight = height * hpPercent
                hp.From = Vector2.new(box.Position.X - 6, box.Position.Y + height)
                hp.To = Vector2.new(box.Position.X - 6, box.Position.Y + height - barHeight)
                hp.Color = Color3.fromRGB(255 * (1 - hpPercent), 255 * hpPercent, 0)
                hp.Visible = onScreen
            end
        else
            drawings.Box.Visible = false
            drawings.HP.Visible = false
        end
    end
end)
