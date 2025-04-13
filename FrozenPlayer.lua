local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.Stepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChildOfClass("Humanoid") then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid.WalkSpeed ~= 0 then
                    humanoid.WalkSpeed = 0
                end
                if humanoid.JumpPower ~= 0 then
                    humanoid.JumpPower = 0
                end
            end
        end
    end
end)
