local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.Stepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("Head") then
                local head = character.Head

                if head.Size ~= Vector3.new(10, 1, 10) then
                    head.Size = Vector3.new(10, 1, 10)
                    head.Transparency = 0.7 -- มองเห็นราง ๆ
                    head.Color = Color3.fromRGB(255, 0, 0) -- สีแดง เพื่อให้เห็นเด่น
                    head.Material = Enum.Material.Neon -- สะท้อนแสงชัดขึ้น
                    head.CanCollide = false
                    head.Massless = true

                    -- ป้องกันหัวลอยหลุด
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = head
                    weld.Part1 = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or head
                    weld.Parent = head
                end
            end
        end
    end
end)
