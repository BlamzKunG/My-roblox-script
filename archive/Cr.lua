-- ใส่ LocalScript นี้ไว้ใน StarterPlayerScripts หรือ StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CreditUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- สร้าง TextLabel
local creditLabel = Instance.new("TextLabel")
creditLabel.Name = "CreditLabel"
creditLabel.Size = UDim2.new(1, 0, 0, 30) -- กว้างเต็มหน้าจอ สูง 30px
creditLabel.Position = UDim2.new(0, 0, 0, 0) -- อยู่ด้านบนสุด
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "By TikTok:Lxxuak" -- เปลี่ยนเป็นชื่อคุณได้เลย
creditLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creditLabel.Font = Enum.Font.GothamBold
creditLabel.TextSize = 20
creditLabel.TextStrokeTransparency = 0.7
creditLabel.TextWrapped = true
creditLabel.Parent = screenGui
