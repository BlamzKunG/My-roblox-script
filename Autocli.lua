getgenv().AutoClaim = true -- เปลี่ยนเป็น false เพื่อหยุดทำงาน

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClaimGacha = ReplicatedStorage.Events.Stats.ClaimGacha
local ClaimSlot = ReplicatedStorage.Events.Stats.ClaimSlot

-- CONFIG: จำนวน Gacha และ Slot ทั้งหมด
local maxGacha = 10
local maxSlots = 10

-- รันใน Task แยก เพื่อไม่บล็อกการทำงานหลัก
task.spawn(function()
    while getgenv().AutoClaim do
        -- เคลม Gacha
        for i = 1, maxGacha do
            local gachaName = string.format("Gacha%03d", i)
            pcall(function()
                ClaimGacha:FireServer(gachaName)
            end)
            task.wait(0.5)
        end

        -- เคลม Slot
        for i = 1, maxSlots do
            local slotName = string.format("Slot%03d", i)
            pcall(function()
                ClaimSlot:InvokeServer(slotName)
            end)
            task.wait(0.5)
        end

        -- รอวนรอบถัดไป
        task.wait(15)
    end
end)
