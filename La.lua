--[[
    Enhanced Kill All Script with UI
    สำหรับการศึกษาและทดสอบระบบป้องกันเท่านั้น
    ฟังก์ชันในสคริปต์นี้มีหลายวิธีเพื่อฆ่าผู้เล่น:
      1. Kill ด้วย RemoteEvent (ถ้ามี)
      2. Kill ด้วยการตั้ง Health = 0
      3. Kill ด้วยการเรียกใช้ BreakJoints (บังคับให้ตัวละครตาย)
      4. Kill ด้วย DamageEvent (ถ้ามี) โดยส่งค่าความเสียหายมหาศาล
      5. Advanced Kill All: สุ่มใช้วิธีต่างๆ สำหรับผู้เล่นแต่ละคน
    UI จะให้คุณเลือกเรียกใช้แต่ละฟังก์ชันผ่านปุ่มกด
    **หมายเหตุ:** โค้ดนี้ใช้สำหรับการศึกษาเท่านั้น
--]]

---------------------------
-- Services and Utilities
---------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- ฟังก์ชันออบฟัสข้อความ (เปลี่ยนตัวเลข ASCII ให้เป็น string)
local function deobfuscate(arr)
    local str = ""
    for _, code in ipairs(arr) do
        str = str .. string.char(code)
    end
    return str
end

-- สร้างชื่อ RemoteEvent และ DamageEvent แบบออบฟัส
local remoteEventName = deobfuscate({75,105,108,108,69,118,101,110,116})       -- "KillEvent"
local damageEventName = deobfuscate({68,97,109,97,103,101,69,118,101,110,116})      -- "DamageEvent"

---------------------------
-- Kill Method Implementations
---------------------------

-- 1. ใช้ RemoteEvent: ส่งคำสั่งให้เซิร์ฟเวอร์ฆ่าผู้เล่น
local function killWithRemoteEvent()
    local remoteEvent = ReplicatedStorage:FindFirstChild(remoteEventName)
    if remoteEvent then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer then
                remoteEvent:FireServer(p)
                print("[RemoteEvent] ส่งคำสั่งฆ่า " .. p.Name)
            end
        end
    else
        warn("ไม่พบ RemoteEvent: " .. remoteEventName)
    end
end

-- 2. ตั้ง Health ให้เป็น 0: แต่บางเกมอาจมีระบบฟื้นฟู Health
local function killWithHealthZero()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid.Health = 0
            print("[Health=0] ตั้ง Health=0 สำหรับ " .. p.Name)
        end
    end
end

-- 3. ใช้ BreakJoints: บังคับให้ตัวละครตายโดยการทำลาย joints
local function killWithBreakJoints()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local humanoid = p.Character:FindFirstChild("Humanoid")
            if humanoid then
                p.Character:BreakJoints()
                print("[BreakJoints] ทำลาย joints ของ " .. p.Name)
            end
        end
    end
end

-- 4. ใช้ DamageEvent: ส่งค่าความเสียหายมหาศาล (math.huge)
local function killWithDamageEvent()
    local damageEvent = ReplicatedStorage:FindFirstChild(damageEventName)
    if damageEvent then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer then
                damageEvent:FireServer(p, math.huge)
                print("[DamageEvent] ส่งความเสียหายมหาศาลให้ " .. p.Name)
            end
        end
    else
        warn("ไม่พบ DamageEvent: " .. damageEventName)
    end
end

-- 5. Advanced Kill All: สำหรับผู้เล่นแต่ละคนสุ่มใช้วิธีใดวิธีหนึ่ง
local function advancedKillAll()
    local methods = {killWithRemoteEvent, killWithHealthZero, killWithBreakJoints, killWithDamageEvent}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            local chosenMethod = methods[math.random(#methods)]
            -- เรียกใช้วิธีที่สุ่มเลือกสำหรับผู้เล่นคนนั้น
            chosenMethod()
            task.wait(math.random(5,15)/10) -- หน่วงเวลาแบบสุ่มเล็กน้อย
        end
    end
    print("Advanced Kill All ดำเนินการเสร็จสิ้น")
end

---------------------------
-- UI Setup
---------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EnhancedKillAllUI"
screenGui.Parent = game.CoreGui

-- สร้าง Frame สำหรับ UI
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 240)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.BackgroundTransparency = 0.3
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Text = "Enhanced Kill All UI"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.Parent = frame

-- ฟังก์ชันสร้างปุ่ม UI
local function createButton(text, posY, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0, 300, 0, 30)
    button.Position = UDim2.new(0, 10, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 20
    button.Parent = frame

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end)
    button.MouseButton1Click:Connect(callback)
end

-- สร้างปุ่มสำหรับแต่ละฟังก์ชัน Kill All
createButton("Kill with RemoteEvent", 40, killWithRemoteEvent)
createButton("Kill with Health=0", 80, killWithHealthZero)
createButton("Kill with BreakJoints", 120, killWithBreakJoints)
createButton("Kill with DamageEvent", 160, killWithDamageEvent)
createButton("Advanced Kill All", 200, advancedKillAll)

---------------------------
-- Additional UI: Toggle Auto-Kill Mode (optional)
---------------------------
local autoKillEnabled = false
local autoKillButton = Instance.new("TextButton")
autoKillButton.Text = "Auto Kill: OFF"
autoKillButton.Size = UDim2.new(0, 320, 0, 40)
autoKillButton.Position = UDim2.new(0.05, 0, 0.6, 0)
autoKillButton.BackgroundColor3 = Color3.new(0, 0, 0.8)
autoKillButton.TextColor3 = Color3.new(1,1,1)
autoKillButton.Font = Enum.Font.SourceSansBold
autoKillButton.TextSize = 24
autoKillButton.Parent = screenGui

autoKillButton.MouseEnter:Connect(function()
    autoKillButton.BackgroundColor3 = Color3.new(0, 0, 0.6)
end)
autoKillButton.MouseLeave:Connect(function()
    autoKillButton.BackgroundColor3 = Color3.new(0, 0, 0.8)
end)

-- ฟังก์ชัน Auto-Kill: เรียก Advanced Kill All ทุกๆ ระยะเวลาที่กำหนด (เช่น ทุก 10 วินาที)
spawn(function()
    while true do
        if autoKillEnabled then
            advancedKillAll()
        end
        task.wait(10)
    end
end)

autoKillButton.MouseButton1Click:Connect(function()
    autoKillEnabled = not autoKillEnabled
    autoKillButton.Text = "Auto Kill: " .. (autoKillEnabled and "ON" or "OFF")
end)

---------------------------
-- Additional Keybind: กด "K" เพื่อเรียก Advanced Kill All
---------------------------
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        advancedKillAll()
    end
end)

print("Enhanced Kill All UI loaded. ใช้ปุ่มใน UIหรือกด K เพื่อเรียกใช้งาน.")
