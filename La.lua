--[[ 
    UI-Controlled Advanced Kill All Script
    สำหรับการศึกษาและทดสอบระบบป้องกันเท่านั้น
    ห้ามนำไปใช้ในเกมหรือเซิร์ฟเวอร์ของผู้อื่นโดยไม่ได้รับอนุญาต
--]]

-- ดึงบริการที่จำเป็น
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- ฟังก์ชันออบฟัสข้อความ (ใช้ตัวเลข ASCII)
local function obfuscateText(arr)
    local str = ""
    for _, code in ipairs(arr) do
        str = str .. string.char(code)
    end
    return str
end

-- ตั้งค่าชื่อ RemoteEvent และ DamageEvent แบบออบฟัส
local remoteName = obfuscateText({75, 105, 108, 108, 69, 118, 101, 110, 116})       -- "KillEvent"
local damageName = obfuscateText({68, 97, 109, 97, 103, 101, 69, 118, 101, 110, 116})  -- "DamageEvent"

---------------------------------------------------
-- ฟังก์ชันสำหรับ Kill All (3 วิธี)
---------------------------------------------------

-- 1. ใช้ RemoteEvent (ถ้ามี)
local function killAllRemote()
    local remoteEvent = ReplicatedStorage:FindFirstChild(remoteName)
    if remoteEvent then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                remoteEvent:FireServer(player)
                print("[Remote] ฆ่า " .. player.Name)
            end
        end
    else
        warn("ไม่พบ RemoteEvent: " .. remoteName)
    end
end

-- 2. ลด Health เป็น 0
local function killAllDirect()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
            print("[Direct] ฆ่า " .. player.Name)
        end
    end
end

-- 3. ใช้ DamageEvent (ถ้ามี)
local function killAllDamage()
    local damageEvent = ReplicatedStorage:FindFirstChild(damageName)
    if damageEvent then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                damageEvent:FireServer(player, math.huge)
                print("[Damage] ฆ่า " .. player.Name)
            end
        end
    else
        warn("ไม่พบ DamageEvent: " .. damageName)
    end
end

-- รวมทุกฟังก์ชันเข้าด้วยกัน
local function executeKillAll()
    local methods = {killAllRemote, killAllDirect, killAllDamage}
    for _, method in ipairs(methods) do
        method()
        task.wait(math.random(0.5, 1.5)) -- หน่วงเวลาแบบสุ่ม
    end
    print("Kill All สำเร็จ")
end

---------------------------------------------------
-- UI สร้างปุ่มกด Kill All
---------------------------------------------------

-- สร้าง UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local button = Instance.new("TextButton")
button.Parent = screenGui
button.Text = "Kill All"
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0.5, -50, 0.8, 0)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20

-- เพิ่มเอฟเฟกต์ Hover เปลี่ยนสี
button.MouseEnter:Connect(function()
    button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
end)
button.MouseLeave:Connect(function()
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end)

-- ฟังก์ชันเมื่อกดปุ่ม
button.MouseButton1Click:Connect(function()
    executeKillAll()
end)

-- กดปุ่ม "K" บนคีย์บอร์ดเพื่อ Kill All ได้ด้วย
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        executeKillAll()
    end
end)

---------------------------------------------------
-- Auto Execute: รอ 2 วิ จากนั้นเพิ่ม UI
---------------------------------------------------
task.wait(2)
print("Kill All UI พร้อมใช้งาน (กดปุ่ม 'Kill All' หรือกด K บนคีย์บอร์ด)")
