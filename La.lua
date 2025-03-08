--[[ 
    Advanced Kill All Script สำหรับการศึกษาและทดสอบระบบป้องกัน
    หมายเหตุ: โค้ดนี้สร้างขึ้นเพื่อการศึกษาเท่านั้น
    ห้ามนำไปใช้ในเกมหรือเซิร์ฟเวอร์ของผู้อื่นโดยไม่ได้รับอนุญาต
--]]

-- ดึงบริการที่จำเป็น
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ฟังก์ชันสำหรับสร้างข้อความจากตัวเลข ASCII (ใช้ในการออบฟัสชื่อ)
local function deobfuscate(arr)
    local str = ""
    for _, code in ipairs(arr) do
        str = str .. string.char(code)
    end
    return str
end

-- สร้างชื่อ RemoteEvent และ DamageEvent แบบออบฟัส
local remoteName = deobfuscate({75, 105, 108, 108, 69, 118, 101, 110, 116})       -- "KillEvent"
local damageName = deobfuscate({68, 97, 109, 97, 103, 101, 69, 118, 101, 110, 116})  -- "DamageEvent"

-- ฟังก์ชันสร้าง delay แบบสุ่ม เพื่อเพิ่มความหลากหลายในการทำงาน
local function randomDelay(min, max)
    min = min or 0.5
    max = max or 1.5
    local delayTime = math.random() * (max - min) + min
    task.wait(delayTime)
end

---------------------------------------------------
-- Method 1: Advanced Kill All ผ่าน RemoteEvent
---------------------------------------------------
local function advancedKillRemote()
    local remoteEvent = ReplicatedStorage:FindFirstChild(remoteName)
    if remoteEvent then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then  -- ข้ามตัว LocalPlayer
                remoteEvent:FireServer(player)
                print("[Remote] ส่งคำสั่งฆ่า " .. player.Name)
                randomDelay(0.1, 0.3)
            end
        end
    else
        warn("ไม่พบ RemoteEvent: " .. remoteName)
    end
end

---------------------------------------------------
-- Method 2: Advanced Kill All โดยปรับค่า Health ให้เป็น 0
---------------------------------------------------
local function advancedKillDirect()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
            print("[Direct] ลด Health เป็น 0 ให้ " .. player.Name)
            randomDelay(0.1, 0.3)
        end
    end
end

---------------------------------------------------
-- Method 3: Advanced Kill All ผ่าน DamageEvent (ถ้ามี)
---------------------------------------------------
local function advancedKillDamage()
    local damageEvent = ReplicatedStorage:FindFirstChild(damageName)
    if damageEvent then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                -- ส่ง Damage จำนวนมหาศาลเพื่อให้แน่ใจว่าผู้เล่นจะตาย
                damageEvent:FireServer(player, math.huge)
                print("[Damage] ส่ง Damage สูงให้ " .. player.Name)
                randomDelay(0.1, 0.3)
            end
        end
    else
        warn("ไม่พบ DamageEvent: " .. damageName)
    end
end

---------------------------------------------------
-- Main Function: Execute Advanced Kill All Methods
-- สุ่มลำดับการทำงานของแต่ละวิธีเพื่อให้โค้ดมีความซับซ้อนมากขึ้น
---------------------------------------------------
local function advancedKillAll()
    print("เริ่มต้นการรัน Advanced Kill All...")
    local methods = {advancedKillRemote, advancedKillDirect, advancedKillDamage}
    
    -- สุ่มลำดับของ methods
    for i = #methods, 2, -1 do
        local j = math.random(i)
        methods[i], methods[j] = methods[j], methods[i]
    end
    
    -- เรียกใช้งานแต่ละวิธี
    for _, method in ipairs(methods) do
        method()
        randomDelay(0.5, 1)
    end
    
    print("Advanced Kill All ทำงานเสร็จสิ้น")
end

---------------------------------------------------
-- Auto Execute: รอให้ระบบโหลดก่อนแล้วเรียก Advanced Kill All
---------------------------------------------------
task.wait(2)
advancedKillAll()
