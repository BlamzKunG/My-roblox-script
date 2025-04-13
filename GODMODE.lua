--// GODMODE แบบครอบจักรวาล //--

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- ป้องกันเลือดลด
task.spawn(function()
	while true do
		task.wait(0.1)
		if char:FindFirstChild("Humanoid") then
			local hum = char.Humanoid
			hum.Health = hum.MaxHealth
		end
	end
end)

-- Hook RemoteEvent ที่เกี่ยวกับดาเมจ
local dangerousRemotes = {"WeaponHit", "WeaponFired", "TakeDamage", "DamageRemote", "HitRemote"}

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
	local method = getnamecallmethod()
	local args = {...}

	if table.find(dangerousRemotes, self.Name) and method == "FireServer" then
		return nil -- ไม่ส่ง = ไม่โดนดาเมจ
	end

	return oldNamecall(self, unpack(args))
end))

-- ลด Hitbox และป้องกันการโดนยิง (แต่อย่าให้หายไปเลย)
task.spawn(function()
	while true do
		task.wait(1)
		char = player.Character or player.CharacterAdded:Wait()
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				part.Size = Vector3.new(0.5, 0.5, 0.5)
				part.Transparency = 0.5
				part.CanCollide = false
				part.Material = Enum.Material.ForceField -- ดูแยกออกว่าถูกปรับ
			end
		end
	end
end)

-- แกล้งระบบด้วยการเปลี่ยน Humanoid
task.delay(2, function()
	local oldHum = char:FindFirstChildOfClass("Humanoid")
	if oldHum then
		local newHum = oldHum:Clone()
		oldHum:Destroy()
		newHum.Parent = char
	end
end)

-- ป้องกันการถูก Kill ด้วยฟังก์ชันอื่น
if setreadonly then
	local mt = getrawmetatable(game)
	setreadonly(mt, false)
	local oldIndex = mt.__index

	mt.__index = newcclosure(function(self, key)
		if tostring(key):lower():find("health") then
			return 100
		end
		return oldIndex(self, key)
	end)
end
