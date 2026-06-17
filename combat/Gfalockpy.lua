local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- ค่าคงที่
local SHOOT_RANGE = 18

-- ระบุทีมของเรา
local function getTeam()
	local teamValue = Players:FindFirstChild("NPCPlayers")
	if teamValue and teamValue:FindFirstChild("Players") and teamValue.Players:FindFirstChild(LocalPlayer.Name) then
		return teamValue.Players[LocalPlayer.Name]:FindFirstChild("_team") and teamValue.Players[LocalPlayer.Name]._team.Value
	end
	return nil
end

-- ลิสต์ศัตรูที่อยู่ในระยะและคนละทีม
local function getEnemyList()
	local enemies = {}
	local myTeam = getTeam()

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local npcData = Players:FindFirstChild("NPCPlayers")
			if npcData and npcData:FindFirstChild("Players") and npcData.Players:FindFirstChild(player.Name) then
				local enemyTeamValue = npcData.Players[player.Name]:FindFirstChild("_team")
				if enemyTeamValue and enemyTeamValue.Value ~= myTeam then
					local dist = (player.Character.HumanoidRootPart.Position - Root.Position).Magnitude
					if dist <= SHOOT_RANGE then
						table.insert(enemies, {
							root = player.Character.HumanoidRootPart,
							player = player,
							dist = dist
						})
					end
				end
			end
		end
	end

	-- เรียงตามระยะใกล้ → ไกล
	table.sort(enemies, function(a, b)
		return a.dist < b.dist
	end)

	return enemies
end

-- เป้าหมายปัจจุบัน
local currentTargetIndex = 1
local enemies = {}

-- ฟังก์ชันเปลี่ยนเป้าหมาย
local function nextTarget()
	enemies = getEnemyList()
	if #enemies > 0 then
		currentTargetIndex = currentTargetIndex + 1
		if currentTargetIndex > #enemies then
			currentTargetIndex = 1
		end
	end
end

-- ลอยตัวได้
Humanoid.PlatformStand = true

-- ตรวจจับปุ่ม R เพื่อเปลี่ยนเป้าหมาย
UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.R then
		nextTarget()
	end
end)

-- เคลื่อนไปยังเป้าหมายปัจจุบัน
RunService.Heartbeat:Connect(function()
	enemies = getEnemyList()
	local targetData = enemies[currentTargetIndex]
	if targetData and targetData.root then
		local tween = TweenService:Create(Root, TweenInfo.new(0.2), {
			CFrame = CFrame.new(targetData.root.Position + Vector3.new(0, 0, -3))
		})
		tween:Play()
	end
end)
