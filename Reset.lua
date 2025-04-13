-- ตัวแปรสำหรับหยุด Loop ทั้งหมด
_G.StopAllScripts = true

-- รีเซ็ตตัวละครให้กลับสู่สภาพปกติ
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

for _, part in pairs(character:GetChildren()) do
	if part:IsA("BasePart") then
		part.Size = Vector3.new(2, 1, 1) -- ขนาดเริ่มต้น
		part.Transparency = 0
		part.CanCollide = true
		part.Material = Enum.Material.Plastic
	end
end

-- คืนค่าชีวิตถ้ามีการปรับ
local humanoid = character:FindFirstChildOfClass("Humanoid")
if humanoid then
	humanoid.Health = humanoid.MaxHealth
end

-- คืน HumanoidRootPart ให้อยู่กับพื้น (ถ้าบินอยู่)
local hrp = character:FindFirstChild("HumanoidRootPart")
if hrp then
	local ray = Ray.new(hrp.Position, Vector3.new(0, -500, 0))
	local hit, pos = workspace:FindPartOnRay(ray, character)
	if pos then
		hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0)) -- ลอยจากพื้นนิดนึง
	end
end

-- แจ้งยืนยัน
game.StarterGui:SetCore("ChatMakeSystemMessage", {
	Text = "[SYSTEM] ทุก Script ถูกหยุดและรีเซ็ตเรียบร้อยแล้ว!",
	Color = Color3.fromRGB(255, 0, 0),
	Font = Enum.Font.SourceSansBold,
	FontSize = Enum.FontSize.Size24
})
