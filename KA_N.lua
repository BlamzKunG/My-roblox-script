-- CONFIG
getgenv().KillAllEnabled = true       -- เปิด/ปิดระบบ Kill All
local toolName = "AWM"
local damage = 100
local shootId = 4
local minDelay, maxDelay = 0.25, 0.75 -- หน่วงระหว่างยิงแต่ละรอบ

-- ย่อ vector
local function vec(x, y, z)
    return Vector3.new(x, y, z)
end

-- เริ่มลูป
task.spawn(function()
    while getgenv().KillAllEnabled do
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer
                and plr.Character
                and plr.Character:FindFirstChild("Head")
                and plr.Character:FindFirstChild("HumanoidRootPart")
                and plr.Character:FindFirstChildOfClass("Humanoid")
                and not plr.Character:FindFirstChildOfClass("ForceField")
                and not plr.Character:FindFirstChildWhichIsA("ForceField", true) -- กรองบาเรียอื่นที่มี "Fire" ด้วย
            then
                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(toolName)
                    or game.Players.LocalPlayer.Character:FindFirstChild(toolName)
                if tool then
                    local targetPart = plr.Character.Head
                    local origin = game.Players.LocalPlayer.Character.Head.Position
                    local dir = (targetPart.Position - origin).Unit

                    -- ยิงปืน
                    local fireArgs = {
                        tool,
                        {
                            id = shootId,
                            charge = 0,
                            origin = origin,
                            dir = dir
                        }
                    }
                    game.ReplicatedStorage.WeaponsSystem.Network.W__red:FireServer(unpack(fireArgs))

                    -- ผลกระทบ
                    local hitArgs = {
                        tool,
                        {
                            p = targetPart.Position,
                            pid = 1,
                            part = targetPart,
                            d = damage,
                            maxDist = (origin - targetPart.Position).Magnitude,
                            h = plr.Character:FindFirstChildOfClass("Humanoid"),
                            m = Enum.Material.Plastic,
                            sid = shootId,
                            t = tick(),
                            n = Vector3.new(0, 1, 0)
                        }
                    }
                    game.ReplicatedStorage.WeaponsSystem.Network.W__it:FireServer(unpack(hitArgs))
                end
            end
        end
        task.wait(math.random() * (maxDelay - minDelay) + minDelay)
    end
end)
