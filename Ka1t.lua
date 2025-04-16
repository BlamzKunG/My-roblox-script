-- CONFIG
local headshotOnly = true -- true = ยิงใส่หัวเท่านั้น

local function getClosestPlayer()
    local closest, dist = nil, math.huge
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer 
            and plr.Character 
            and plr.Character:FindFirstChild("HumanoidRootPart") 
            and plr.Character:FindFirstChild("Head") 
            and not plr.Character:FindFirstChildOfClass("ForceField") then -- ข้ามถ้ามีบาเรีย

            local d = (plr.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                dist = d
                closest = plr
            end
        end
    end
    return closest
end
-- FUNCTION ยิงกระสุนแบบ Fake ไปที่เป้าหมาย
local function fireSilent()
    local target = getClosestPlayer()
    if not target then return end

    local targetPart = headshotOnly and target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
    if not targetPart then return end

    -- ยิงกระสุน
    local dir = (targetPart.Position - game.Players.LocalPlayer.Character.Head.Position).Unit

    local args = {
        [1] = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"), -- เช่น AWM
        [2] = {
            id = 1,
            charge = 0,
            dir = dir,
            origin = game.Players.LocalPlayer.Character.Head.Position
        }
    }

    game.ReplicatedStorage.WeaponsSystem.Network.WeaponFired:FireServer(unpack(args))

    -- ส่งผลกระทบว่าโดนเป้า
    local args2 = {
        [1] = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"),
        [2] = {
            p = targetPart.Position,
            pid = 1,
            part = targetPart,
            d = 100, -- ดาเมจใส่เองได้
            maxDist = 100,
            h = targetPart,
            m = Enum.Material.Plastic,
            sid = 1,
            t = tick(),
            n = Vector3.new(0, 1, 0)
        }
    }

    game.ReplicatedStorage.WeaponsSystem.Network.WeaponHit:FireServer(unpack(args2))
end

-- ยิงทุก 0.2 วิ
while task.wait(0.1) do
    fireSilent()
end
