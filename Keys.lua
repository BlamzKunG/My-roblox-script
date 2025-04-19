-- Configuration
local discordInvite = "https://discord.com/invite/AbmG6nYhAp"
local githubRawKeyURL = "https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Key.txt"

-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "KeySystemUI"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Key System"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24

local keyBox = Instance.new("TextBox", mainFrame)
keyBox.PlaceholderText = "Enter your key here"
keyBox.Size = UDim2.new(1, -20, 0, 30)
keyBox.Position = UDim2.new(0, 10, 0, 50)
keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Text = ""
keyBox.ClearTextOnFocus = false

local submitButton = Instance.new("TextButton", mainFrame)
submitButton.Size = UDim2.new(0.5, -15, 0, 30)
submitButton.Position = UDim2.new(0, 10, 0, 100)
submitButton.Text = "Submit"
submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local getKeyButton = Instance.new("TextButton", mainFrame)
getKeyButton.Size = UDim2.new(0.5, -15, 0, 30)
getKeyButton.Position = UDim2.new(0.5, 5, 0, 100)
getKeyButton.Text = "Get Key"
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local statusLabel = Instance.new("TextLabel", mainFrame)
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 150)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = ""
statusLabel.TextSize = 18

-- Toggle UI Button
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 100, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Toggle UI"
toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Submit Key
submitButton.MouseButton1Click:Connect(function()
	local inputKey = keyBox.Text

	pcall(function()
		local response = game:HttpGet(githubRawKeyURL)
		local validKey = string.gsub(response, "%s+", "")

		if inputKey == validKey then
			statusLabel.Text = "Access Granted"
			statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
			wait(2)
			screenGui:Destroy()
			-- Place code here to run after successful key check
			print("KEY VALIDATED!")
		else
			statusLabel.Text = "Invalid Key"
			statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		end
	end)
end)

-- Get Key (Copy Discord link)
getKeyButton.MouseButton1Click:Connect(function()
	setclipboard(discordInvite)
	statusLabel.Text = "Discord Link Copied!"
	statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
end)
