        local RunService = game:GetService("RunService")
        local LocalPlayer = game.Players.LocalPlayer
    
        RunService.RenderStepped:Connect(function()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local character = player.Character
                    if character and character:FindFirstChild("Head") then
                        local head = character.Head
                        head.Size = Vector3.new(30, 100, 30)
                        head.Transparency = 1
                        head.CanCollide = false
    
                        local mesh = head:FindFirstChildOfClass("SpecialMesh")
                        if mesh then mesh:Destroy() end
                    end
                end
            end
        end)
