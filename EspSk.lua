local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local skeletonParts = {
	{"Head", "UpperTorso"},
	{"UpperTorso", "LowerTorso"},
	{"UpperTorso", "LeftUpperArm"},
	{"LeftUpperArm", "LeftLowerArm"},
	{"LeftLowerArm", "LeftHand"},
	{"UpperTorso", "RightUpperArm"},
	{"RightUpperArm", "RightLowerArm"},
	{"RightLowerArm", "RightHand"},
	{"LowerTorso", "LeftUpperLeg"},
	{"LeftUpperLeg", "LeftLowerLeg"},
	{"LeftLowerLeg", "LeftFoot"},
	{"LowerTorso", "RightUpperLeg"},
	{"RightUpperLeg", "RightLowerLeg"},
	{"RightLowerLeg", "RightFoot"},
}

local espData = {} -- เก็บเส้นแต่ละคน

local function createLine()
	local line = Drawing.new("Line")
	line.Thickness = 1.5
	line.Color = Color3.fromRGB(0, 255, 0)
	line.Transparency = 1
	return line
end

local function setupESPForPlayer(player)
	if player == LocalPlayer then return end
	espData[player] = {}

	for _ = 1, #skeletonParts do
		table.insert(espData[player], createLine())
	end
end

local function removeESPForPlayer(player)
	if espData[player] then
		for _, line in ipairs(espData[player]) do
			line:Remove()
		end
		espData[player] = nil
	end
end

-- สร้าง ESP ให้ทุกคนตอนเริ่ม
for _, player in ipairs(Players:GetPlayers()) do
	setupESPForPlayer(player)
end

-- เมื่อมีคนใหม่เข้ามา
Players.PlayerAdded:Connect(setupESPForPlayer)
Players.PlayerRemoving:Connect(removeESPForPlayer)

-- อัปเดตตำแหน่ง ESP
RunService.RenderStepped:Connect(function()
	for player, lines in pairs(espData) do
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")

		if char and hum and hum.Health > 0 then
			for i, bone in ipairs(skeletonParts) do
				local part0 = char:FindFirstChild(bone[1])
				local part1 = char:FindFirstChild(bone[2])

				if part0 and part1 then
					local pos0, on0 = Camera:WorldToViewportPoint(part0.Position)
					local pos1, on1 = Camera:WorldToViewportPoint(part1.Position)

					if on0 and on1 then
						lines[i].From = Vector2.new(pos0.X, pos0.Y)
						lines[i].To = Vector2.new(pos1.X, pos1.Y)
						lines[i].Visible = true
					else
						lines[i].Visible = false
					end
				else
					lines[i].Visible = false
				end
			end
		else
			for _, line in ipairs(lines) do
				line.Visible = false
			end
		end
	end
end)
