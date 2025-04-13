local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

spawn(function()
    while true do
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local targetChar = player.Character
                local myChar = LocalPlayer.Character

                if targetChar and myChar and
                   targetChar:FindFirstChild("Humanoid") and targetChar.Humanoid.Health > 0 and
                   targetChar:FindFirstChild("HumanoidRootPart") and
                   myChar:FindFirstChild("HumanoidRootPart") then

                    -- ตำแหน่งที่ดึงมา (หน้าตัวเอง 3 studs)
                    local front = myChar.HumanoidRootPart.CFrame.LookVector * 3
                    local newPos = myChar.HumanoidRootPart.Position + front

                    -- ดึงมา
                    targetChar.HumanoidRootPart.CFrame = CFrame.new(newPos)

                    -- ทำซ้ำเฉพาะ 1 คนก่อน รอก่อนดึงคนอื่น
                    wait(1)
                end
            end
        end
        wait(1)
    end
end)
