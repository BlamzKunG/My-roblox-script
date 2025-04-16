-- สมมติว่าเราจะใช้ UUID ตัวแรกที่เจอจากกระเป๋า
local relicContainer = game.Players.LocalPlayer.PlayerGui.MainUI.CenterMenu["遺器"].PetsContainer.Right.List
local firstUUID = nil

for _, item in pairs(relicContainer:GetChildren()) do
    if item:IsA("Frame") then
        firstUUID = item.Name
        break
    end
end

if firstUUID then
    local args = {
        [1] = "Golden",
        [2] = { [1] = firstUUID,
                [2] = firstUUID, 
                [3] = firstUUID, 
                [4] = firstUUID 
               }
    }

    game:GetService("ReplicatedStorage").Events.Pets.Re_PetFuse:FireServer(unpack(args))
else
    warn("ไม่พบ Relic ในกระเป๋า")
end
