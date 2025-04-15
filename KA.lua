local function fireAll()
    for _, target in ipairs(game.Players:GetPlayers()) do
        if target ~= game.Players.LocalPlayer and target.Character and target.Character:FindFirstChild("Head") then
            local head = target.Character.Head
            local origin = game.Players.LocalPlayer.Character.Head.Position
            local dir = (head.Position - origin).Unit

            -- ยิง
            local args = {
                [1] = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"),
                [2] = {
                    id = 1,
                    charge = 0,
                    dir = dir,
                    origin = origin
                }
            }

            game.ReplicatedStorage.WeaponsSystem.Network.WeaponFired:FireServer(unpack(args))

            -- ส่งผลกระทบว่าโดน
            local args2 = {
                [1] = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"),
                [2] = {
                    p = head.Position,
                    pid = 1,
                    part = head,
                    d = 100, -- ดาเมจสูงสุด
                    maxDist = 100,
                    h = head,
                    m = Enum.Material.Plastic,
                    sid = 1,
                    t = tick(),
                    n = Vector3.new(0, 1, 0)
                }
            }

            game.ReplicatedStorage.WeaponsSystem.Network.WeaponHit:FireServer(unpack(args2))
        end
    end
end

-- เรียกใช้ทุก 1 วินาที
while task.wait(0.1) do
    fireAll()
end
