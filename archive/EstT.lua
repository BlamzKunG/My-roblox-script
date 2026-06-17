local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local tracerData = {}

local function createTracer()
	local line = Drawing.new("Line")
	line.Thickness = 1.5
	line.Color = Color3.fromRGB(255, 0, 0)
	line.Transparency = 1
	return line
end

local function setupTracerForPlayer(player)
	if player == LocalPlayer then return end
	tracerData[player] = createTracer()
end

local function removeTracerForPlayer(player)
	if tracerData[player] then
		tracerData[player]:Remove()
		tracerData[player] = nil
	end
end

-- ตั้งค่าให้ผู้เล่นที่มีอยู่แล้ว
for _, player in ipairs(Players:GetPlayers()) do
	setupTracerForPlayer(player)
end

-- เพิ่มสำหรับผู้เล่นใหม่
Players.PlayerAdded:Connect(setupTracerForPlayer)
Players.PlayerRemoving:Connect(removeTracerForPlayer)

RunService.RenderStepped:Connect(function()
	for player, line in pairs(tracerData) do
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if char and root and hum and hum.Health > 0 then
			local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)

			if onScreen then
				local screenCenterBottom = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
				line.From = screenCenterBottom
				line.To = Vector2.new(screenPos.X, screenPos.Y)
				line.Visible = true
			else
				line.Visible = false
			end
		else
			line.Visible = false
		end
	end
end)
