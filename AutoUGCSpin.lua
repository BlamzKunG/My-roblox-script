getgenv().AutoUGCSpin = true -- เปลี่ยนเป็น false เพื่อหยุดทำงาน

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UGCFire = ReplicatedStorage.Events.Wheel.UGCSpin

task.spawn(function()
    while getgenv().AutoUGCSpin do
        pcall(function()
            UGCFire:InvokeServer(true)
        end)
        task.wait(1) -- เวลารอระหว่างสปิน ปรับได้ตามเกมกำหนด cooldown
    end
end)
