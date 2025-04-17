local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClaimGacha = ReplicatedStorage.Events.Stats.ClaimGacha
local ClaimSlot = ReplicatedStorage.Events.Stats.ClaimSlot

-- CONFIG: จำนวนสูงสุดของ Gacha และ Slot ที่ต้องการเคลม
local maxGacha = 10 -- เปลี่ยนตามจำนวน Gacha ที่มี
local maxSlots = 10 -- เปลี่ยนตามจำนวน Slot ที่มี

-- เคลม Gacha ทั้งหมด
for i = 1, maxGacha do
    local gachaName = string.format("Gacha%03d", i)
    pcall(function()
        ClaimGacha:FireServer(gachaName)
    end)
    task.wait(0.1) -- ดีเลย์เพื่อความปลอดภัย
end

-- เคลม Slot ทั้งหมด
for i = 1, maxSlots do
    local slotName = string.format("Slot%03d", i)
    pcall(function()
        ClaimSlot:InvokeServer(slotName)
    end)
    task.wait(10)
end
