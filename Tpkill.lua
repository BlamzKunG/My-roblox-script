local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local HEIGHT_OFFSET = 5
local BACK_OFFSET = 5
local STAY_DURATION = 10

-- ฟังก์ชันพาเราไปอยู่เหนือหัว-ด้านหลังเป้าหมาย
local function stayAboveTarget(targetChar)
	local startTime = tick()

	while tick() - startTime < STAY_DURATION do
		if not targetChar or not targetChar:FindFirstChild("Humanoid") or not targetChar:FindFirstChild("HumanoidRootPart") then
			break
		end

		local humanoid = targetChar:FindFirstChild("Humanoid")
		local hrp = targetChar:FindFirstChild("HumanoidRootPart")

		if humanoid.Health <= 0 then
			break
		end

		-- คำนวณตำแหน่ง
		local behindPos = hrp.Position - (hrp.CFrame.LookVector * BACK_OFFSET)
		local floatPos = behindPos + Vector3.new(0, HEIGHT_OFFSET, 0)

		-- ย้ายตัวเราไปตำแหน่งนั้น และหันหน้าไปทางเป้าหมาย
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character:PivotTo(CFrame.new(floatPos, hrp.Position))
		end

		task.wait(0.2)
	end
end

-- ลูปหาเป้าหมายใหม่ตลอด
while true do
	task.wait(0.5)

	local myChar = LocalPlayer.Character
	if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then continue end

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
			local targetHum = player.Character.Humanoid

			if targetHum.Health > 0 then
				stayAboveTarget(player.Character)
				break
			end
		end
	end
end
