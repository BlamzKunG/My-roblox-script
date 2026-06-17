getgenv().AutoRebirth = true -- เปลี่ยนเป็น false เพื่อหยุดทำงาน

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rebirth = ReplicatedStorage.Events.Stats.RebirthUp

task.spawn(function()
    while getgenv().AutoRebirth do
        pcall(function()
            Rebirth:FireServer()
        end)
        task.wait(1) -- หน่วงเวลา เพื่อไม่ให้ spam จนโดนเตะ (ปรับได้)
    end
end)
