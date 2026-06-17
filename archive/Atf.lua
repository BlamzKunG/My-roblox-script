local player = game.Players.LocalPlayer
local relicUI = player.PlayerGui.MainUI.CenterMenu:FindFirstChildWhichIsA("Frame") -- 避ชื่อภาษาจีน

if relicUI and relicUI:FindFirstChild("PetsContainer") then
    local list = relicUI.PetsContainer.Right.List
    local uuidList = {}

    for _, item in pairs(list:GetChildren()) do
        if item:IsA("Frame") then
            table.insert(uuidList, item.Name)
        end
    end

    for _, uuid in pairs(uuidList) do
        local fuseSet = {uuid, uuid, uuid, uuid}
        local args = {
            [1] = "Golden",
            [2] = fuseSet
        }
        game:GetService("ReplicatedStorage").Events.Pets.Re_PetFuse:FireServer(unpack(args))
        task.wait(0.2)
    end
else
    warn("ไม่พบ UI Relic")
end
