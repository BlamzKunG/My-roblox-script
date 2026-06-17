getgenv().AutoHatch = true -- เปลี่ยนเป็น false เพื่อหยุดทำงาน

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Hatch = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Pets"):WaitForChild("Re_Draw")

task.spawn(function()
    while getgenv().AutoHatch do
        pcall(function()
            local args = {
                [1] = "TripleHatch", -- หรือ "SingleHatch" ได้เช่นกัน
                [2] = "Draw005",     -- ชื่อกาชา
                [3] = {
                    [1] = "Pet025",  -- รายชื่อ Pet ที่จะ Auto Delete ทันทีหลังสุ่มได้
                    [2] = "Pet026",
                    [3] = "Pet027",
                    [4] = "Pet028",
                    [5] = "Pet029"
                }
            }
            Hatch:FireServer(unpack(args))
        end)
        task.wait(10) -- สุ่มทุก 10 วินาที
    end
end)
