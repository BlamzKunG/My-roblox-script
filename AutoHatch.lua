getgenv().AutoHatch = true -- เปลี่ยนเป็น false เพื่อหยุดทำงาน

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Hatch = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Pets"):WaitForChild("Re_Draw")

task.spawn(function()
    while getgenv().AutoHatch do
        pcall(function()
            local args = {
                [1] = "TripleHatch", -- เปลี่ยนเป็น "SingleHatch" ได้ถ้าต้องการ
                [2] = "Draw005",     -- กาชาที่จะสุ่ม
                [3] = {
                    [1] = "Pet025",
                    [2] = "Pet026",
                    [3] = "Pet027",
                    [4] = "Pet028",
                    [5] = "Pet029"
                }
            }
            Hatch:FireServer(unpack(args))
        end)
        task.wait(60) -- สุ่มทุก 60 วินาที
    end
end)
