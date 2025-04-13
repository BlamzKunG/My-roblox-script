local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local HEIGHT_OFFSET = 5
local BACK_OFFSET = 5

-- หาตำแหน่งด้านหลังเป้าหมาย
local function getFloatPosition(targetChar)
	if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
		local hrp = targetChar.HumanoidRootPart
		local behindPos = hrp.Position - (hrp.CFrame.LookVector * BACK_OFFSET)
		local floatPos = behindPos + Vector3.new(0, HEIGHT_OFFSET, 0)
		return CFrame.new(floatPos, hrp.Position)
	end
end

-- หาเป้าหมายที่มีชีวิต
local function getAliveTarget()
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
			if player.Character.Humanoid.Health > 0 then
				return player.Character
			end
		end
	end
	return nil
end

-- ลูปบินตามเป้าหมาย
while true do
	task.wait(0.1)

	local targetChar = getAliveTarget()
	local myChar = LocalPlayer.Character

	if targetChar and myChar and myChar:FindFirstChild("HumanoidRootPart") then
		local targetCFrame = getFloatPosition(targetChar)
		if targetCFrame then
			-- ปลด anchor ก่อนบิน
			myChar.HumanoidRootPart.Anchored = false

			-- ค่อย ๆ ย้ายตำแหน่งไปใกล้ตำแหน่งใหม่แบบ smooth
			myChar:PivotTo(targetCFrame:Lerp(myChar:GetPivot(), 0.2))
		end
	end
end
