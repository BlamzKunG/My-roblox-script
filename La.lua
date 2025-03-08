local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ฟังก์ชันออบฟัสชื่อ RemoteEvent ("KillEvent")
local function _obfName()
    local nums = {75, 105, 108, 108, 69, 118, 101, 110, 116}  -- ตัวเลข ASCII สำหรับ "KillEvent"
    local str = ""
    for _, n in ipairs(nums) do
        str = str .. string.char(n)
    end
    return str
end

local _remoteName = _obfName()

---------------------------------------------------
-- Function 1: Kill All ผ่าน Remote Event
---------------------------------------------------
local function killAllRemote()
    local remoteEvent = ReplicatedStorage:FindFirstChild(_remoteName)
    if remoteEvent then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer then  -- ไม่ยิงตัวเอง
                remoteEvent:FireServer(p)
            end
        end
        print("killAllRemote executed.")
    else
        warn("ไม่พบ RemoteEvent: " .. _remoteName)
    end
end

---------------------------------------------------
-- Function 2: Kill All โดยปรับ Health ให้เป็น 0
---------------------------------------------------
local function killAllDirect()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid.Health = 0
        end
    end
    print("killAllDirect executed.")
end

---------------------------------------------------
-- Function 3: Kill All ผ่าน Damage Event (ถ้ามี)
---------------------------------------------------
local function killAllDamage()
    local damageEvent = ReplicatedStorage:FindFirstChild("DamageEvent")
    if damageEvent then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer then
                damageEvent:FireServer(p, 99999)  -- ส่งค่า Damage สูงเพื่อฆ่าผู้เล่น
            end
        end
        print("killAllDamage executed.")
    else
        warn("ไม่พบ DamageEvent ใน ReplicatedStorage")
    end
end

---------------------------------------------------
-- การเรียกใช้งานอัตโนมัติ (ไม่ต้องกดปุ่ม)
---------------------------------------------------
local function autoExecute()
    local waitTime = 1  -- รอ 1 วินาทีเพื่อให้แน่ใจว่าข้อมูลโหลดครบ
    task.wait(waitTime)
    killAllRemote()
    task.wait(waitTime)
    killAllDirect()
    task.wait(waitTime)
    killAllDamage()
end

-- เรียกใช้ฟังก์ชัน autoExecute เพื่อทดสอบ kill all ทุกแบบ
autoExecute()
