local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AntiAFK_GUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 80)
frame.Position = UDim2.new(0.7, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.5, 0)
title.Text = "Anti-AFK: Active"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, 0, 0.5, 0)
status.Position = UDim2.new(0, 0, 0.5, 0)
status.Text = "Waiting for AFK event..."
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.BackgroundTransparency = 1
status.Font = Enum.Font.SourceSans
status.TextSize = 20

local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 100, 0, 30)
toggleBtn.Position = UDim2.new(0.5, -50, 1, -40)
toggleBtn.Text = "Toggle UI"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.BorderSizePixel = 0

local uiVisible = true
toggleBtn.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	frame.Visible = uiVisible
end)

player.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
	status.Text = "Roblox tried to AFK-kick you!"
	task.delay(2, function()
		status.Text = "Waiting for AFK event..."
	end)
end)

task.spawn(function()
	local rotationAmount = math.rad(1)
	local toggle = true

	while true do
		task.wait(60)
		local current = camera.CFrame
		if toggle then
			camera.CFrame = current * CFrame.Angles(0, rotationAmount, 0)
		else
			camera.CFrame = current * CFrame.Angles(0, -rotationAmount, 0)
		end
		toggle = not toggle
	end
end)
