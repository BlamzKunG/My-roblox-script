local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local clicking = true -- ตั้งให้เป็น true เพื่อเริ่มออโต้คลิก

RunService.RenderStepped:Connect(function()
	if clicking then
		VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0) -- mouse down
		VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0) -- mouse up
		wait(0.5) -- เวลาระหว่างคลิก ปรับให้เร็ว/ช้ากว่านี้ได้
	end
end)
