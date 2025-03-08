--[[
    Ultimate Kill All – ALL FUNCTIONS Script with UI
    สำหรับการศึกษาและทดสอบระบบป้องกันเท่านั้น
    โค้ดนี้รวมทุกเทคนิคที่เป็นไปได้สำหรับ Kill All
    **ห้ามนำไปใช้ในเกมหรือเซิร์ฟเวอร์ของผู้อื่นโดยไม่ได้รับอนุญาต**
--]]

---------------------------
-- Services & Utilities
---------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- ฟังก์ชัน deobfuscate สำหรับสร้างชื่อจากตัวเลข ASCII
local function deobfuscate(arr)
    local str = ""
    for _, code in ipairs(arr) do
        str = str .. string.char(code)
    end
    return str
end

-- สร้างชื่อ Event แบบออบฟัส
local remoteEventName = deobfuscate({75,105,108,108,69,118,101,110,116})       -- "KillEvent"
local damageEventName = deobfuscate({68,97,109,97,103,101,69,118,101,110,116})      -- "DamageEvent"

---------------------------
-- Kill Method Functions
---------------------------

-- 1. ใช้ RemoteEvent (ถ้ามี)
local function killWithRemoteEvent(player)
    local remoteEvent = ReplicatedStorage:FindFirstChild(remoteEventName)
    if remoteEvent then
        remoteEvent:FireServer(player)
        print("[RemoteEvent] ส่งคำสั่งฆ่า " .. player.Name)
    end
end

-- 2. ใช้ DamageEvent (ถ้ามี)
local function killWithDamageEvent(player)
    local damageEvent = ReplicatedStorage:FindFirstChild(damageEventName)
    if damageEvent then
        damageEvent:FireServer(player, math.huge)
        print("[DamageEvent] ส่งความเสียหายมหาศาลให้ " .. player.Name)
    end
end

-- 3. ตั้ง Health เป็น 0
local function killWithHealthZero(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
        print("[Health=0] ตั้ง Health=0 ให้ " .. player.Name)
    end
end

-- 4. ใช้ TakeDamage(math.huge)
local function killWithTakeDamage(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:TakeDamage(math.huge)
        print("[TakeDamage] ใช้ TakeDamage ให้ " .. player.Name)
    end
end

-- 5. ใช้ BreakJoints
local function killWithBreakJoints(player)
    if player.Character then
        player.Character:BreakJoints()
        print("[BreakJoints] ทำลาย joints ของ " .. player.Name)
    end
end

-- 6. ใช้ ChangeState เป็น Dead
local function killWithChangeState(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
        print("[ChangeState] เปลี่ยน state ให้ Dead สำหรับ " .. player.Name)
    end
end

-- 7. ทำลาย Humanoid object
local function killWithDestroyHumanoid(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:Destroy()
        print("[DestroyHumanoid] ทำลาย Humanoid ของ " .. player.Name)
    end
end

-- 8. สร้าง Explosion ที่ตำแหน่ง Character
local function killWithExplosion(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local explosion = Instance.new("Explosion")
        explosion.Position = player.Character.HumanoidRootPart.Position
        explosion.BlastPressure = 500000
        explosion.BlastRadius = 10
        explosion.Parent = Workspace
        print("[Explosion] สร้าง Explosion ใกล้ " .. player.Name)
    end
end

-- 9. ทำลาย Character ทั้งหมด
local function killWithDestroyCharacter(player)
    if player.Character then
        player.Character:Destroy()
        print("[DestroyCharacter] ทำลาย Character ของ " .. player.Name)
    end
end

---------------------------
-- Combined Force Kill Function for One Player
---------------------------
local function forceKillPlayer(player)
    if player == Players.LocalPlayer then return end
    -- เรียกใช้ทุกวิธีเพื่อให้แน่ใจว่าตายจริง
    killWithRemoteEvent(player)
    killWithDamageEvent(player)
    killWithHealthZero(player)
    killWithTakeDamage(player)
    killWithBreakJoints(player)
    killWithChangeState(player)
    killWithDestroyHumanoid(player)
    killWithExplosion(player)
    killWithDestroyCharacter(player)
end

---------------------------
-- Kill All Function (Apply to ทุกผู้เล่น)
---------------------------
local function killAllEverything()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            forceKillPlayer(p)
        end
    end
    print("Kill All – ALL FUNCTIONS executed for all players.")
end

---------------------------
-- UI Setup
---------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateKillAllUI"
screenGui.Parent = game.CoreGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0.05, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.BackgroundTransparency = 0.3
frame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Text = "Ultimate Kill All – ALL FUNCTIONS"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 28
title.Parent = frame

-- ฟังก์ชันสร้างปุ่ม UI
local function createButton(text, posY, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0, 360, 0, 40)
    button.Position = UDim2.new(0, 20, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 24
    button.Parent = frame

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end)
    button.MouseButton1Click:Connect(callback)
end

-- สร้างปุ่มสำหรับแต่ละฟังก์ชันแยก
createButton("RemoteEvent Kill", 60, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            killWithRemoteEvent(p)
        end
    end
end)

createButton("DamageEvent Kill", 110, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            killWithDamageEvent(p)
        end
    end
end)

createButton("Health=0 Kill", 160, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            killWithHealthZero(p)
        end
    end
end)

createButton("TakeDamage Kill", 210, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            killWithTakeDamage(p)
        end
    end
end)

createButton("BreakJoints Kill", 260, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            killWithBreakJoints(p)
        end
    end
end)

createButton("ChangeState Kill", 310, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            killWithChangeState(p)
        end
    end
end)

createButton("Destroy Humanoid", 360, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            killWithDestroyHumanoid(p)
        end
    end
end)

createButton("Explosion Kill", 410, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            killWithExplosion(p)
        end
    end
end)

createButton("Destroy Character", 460, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            killWithDestroyCharacter(p)
        end
    end
end)

-- ปุ่มสำหรับเรียกใช้ทุกฟังก์ชันพร้อมกัน
createButton("KILL ALL – ALL FUNCTIONS", 510, killAllEverything)

---------------------------
-- Additional Keybind: กด "K" เพื่อเรียกใช้ Kill All แบบ Ultimate
---------------------------
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        killAllEverything()
    end
end)

print("Ultimate Kill All – ALL FUNCTIONS UI loaded. ใช้ปุ่มใน UIหรือกด K เพื่อเรียกใช้.")
