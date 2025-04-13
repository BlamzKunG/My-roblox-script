local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

RunService.RenderStepped:Connect(function()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
    local myPos = myChar.HumanoidRootPart.Position + Vector3.new(2, 0, 2) -- ห่างจากเรานิดนึง

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = player.Character.HumanoidRootPart
            targetHRP.CFrame = CFrame.new(myPos + Vector3.new(math.random(-3,3), 0, math.random(-3,3)))
            targetHRP.Velocity = Vector3.zero
            targetHRP.RotVelocity = Vector3.zero
        end
    end
end)
