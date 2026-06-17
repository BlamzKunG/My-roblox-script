local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

RunService.RenderStepped:Connect(function()
    -- หันกล้องลงพื้น
    local camPos = Camera.CFrame.Position
    Camera.CFrame = CFrame.new(camPos, camPos + Vector3.new(0, -1, 0))

    -- ถ้าผู้เล่นมีไอเทมในช่อง 3 ของ Hotbar (Backpack index 3)
    local tools = LocalPlayer.Backpack:GetChildren()
    if tools[3] then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid:FindFirstChildOfClass("Tool") ~= tools[3] then
            humanoid:EquipTool(tools[3])
        end
    end
end)
