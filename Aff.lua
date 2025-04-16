--loadstring(game:HttpGet(""))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Ifpydie.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/CA-SC-AF.lua"))()
--loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/KillForAutoFarm.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/KA.lua"))()
--loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/AutoRejoin.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/AutoRejoin30s.lua"))()

-- กำหนดจุดปลอดภัย (แก้ไข Vector3 ตามจุดที่ต้องการ)
local safePosition = Vector3.new(0, 200, 0) -- ย้ายขึ้นไปกลางอากาศ

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- ลบ Force เก่าออกถ้ามี
for _, v in pairs(hrp:GetChildren()) do
    if v:IsA("BodyPosition") or v:IsA("BodyGyro") then
        v:Destroy()
    end
end

-- สร้าง BodyPosition ให้ลอยค้าง
local bodyPos = Instance.new("BodyPosition")
bodyPos.Position = safePosition
bodyPos.MaxForce = Vector3.new(1e6, 1e6, 1e6)
bodyPos.P = 12500
bodyPos.D = 1000
bodyPos.Parent = hrp

-- สร้าง BodyGyro ให้หมุนค้าง
local bodyGyro = Instance.new("BodyGyro")
bodyGyro.CFrame = hrp.CFrame
bodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
bodyGyro.P = 3000
bodyGyro.Parent = hrp

-- เทเลพอร์ตตัวละครไปตำแหน่งปลอดภัย
hrp.CFrame = CFrame.new(safePosition)

-- ล็อกตำแหน่งซ้ำทุก 2 วินาที (กันหลุด)
while true do
    task.wait(2)
    bodyPos.Position = safePosition
end
