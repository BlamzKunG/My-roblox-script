local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HeroAttack = ReplicatedStorage.Events.Hero.HeroAttack

-- โจมตีทุก Pet ใน workspace.UserPets ของเรา
local function attackAllPets()
    local petsFolder = workspace:FindFirstChild("UserPets")
    if not petsFolder then return end

    for _, petOwner in pairs(petsFolder:GetChildren()) do
        if petOwner.Name == tostring(game.Players.LocalPlayer.UserId) then
            for _, pet in pairs(petOwner:GetChildren()) do
                HeroAttack:FireServer(pet)
            end
        end
    end
end

-- สั่งให้โจมตีวนเรื่อย ๆ ทุก 0.1 วิ (ตีไวมาก)
while task.wait(0.05) do
    attackAllPets()
end
