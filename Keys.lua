-- Configuration
local discordInvite = "https://discord.gg/YOURINVITE"
local githubRawKeyURL = "https://raw.githubusercontent.com/yourusername/yourrepo/main/key.txt"

-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "KeySystemUI"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 350, 0, 220)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local UICorner = Instance.new("UICorner", mainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Key System Access"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24

local keyBox = Instance.new("TextBox", mainFrame)
keyBox.PlaceholderText = "Enter your key"
keyBox.Size = UDim2.new(1, -40, 0, 35)
keyBox.Position = UDim2.new(0, 20, 0, 60)
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
keyBox.ClearTextOnFocus = false

local keyBoxCorner = Instance.new("UICorner", keyBox)
keyBoxCorner.CornerRadius = UDim.new(0, 6)

local submitButton = Instance.new("TextButton", mainFrame)
submitButton.Size = UDim2.new(0.5, -25, 0, 35)
submitButton.Position = UDim2.new(0, 20, 0, 110)
submitButton.Text = "Submit"
submitButton.Font = Enum.Font.GothamBold
submitButton.TextSize = 18
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Instance.new("UICorner", submitButton).CornerRadius = UDim.new(0, 6)

local getKeyButton = Instance.new("TextButton", mainFrame)
getKeyButton.Size = UDim2.new(0.5, -25, 0, 35)
getKeyButton.Position = UDim2.new(0.5, 5, 0, 110)
getKeyButton.Text = "Get Key"
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.TextSize = 18
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
Instance.new("UICorner", getKeyButton).CornerRadius = UDim.new(0, 6)

local statusLabel = Instance.new("TextLabel", mainFrame)
statusLabel.Size = UDim2.new(1, -40, 0, 35)
statusLabel.Position = UDim2.new(0, 20, 0, 160)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = ""
statusLabel.TextSize = 18
statusLabel.Font = Enum.Font.Gotham

-- Toggle UI Button
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 120, 0, 35)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Toggle UI"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 16
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Drag Fix (mobile friendly)
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Key Checking Logic
submitButton.MouseButton1Click:Connect(function()
	local inputKey = keyBox.Text

	pcall(function()
		local response = game:HttpGet(githubRawKeyURL)
		local lines = string.split(response, "\n")
		local found = false

		for _, line in pairs(lines) do
			if inputKey == string.gsub(line, "%s+", "") then
				found = true
				break
			end
		end

		if found then
			statusLabel.Text = "Access Granted"
			statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
			wait(2)
			screenGui:Destroy()
			-- ใส่โค้ดที่ต้องการรันหลังจากยืนยัน key ได้ที่นี่
			print("KEY VERIFIED!")
		else
			statusLabel.Text = "Invalid Key"
			statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		end
	end)
end)

-- Copy Discord link
getKeyButton.MouseButton1Click:Connect(function()
	setclipboard(discordInvite)
	statusLabel.Text = "Discord Link Copied!"
	statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
end)
