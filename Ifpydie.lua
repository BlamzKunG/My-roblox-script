local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ลิงก์ GitHub ที่เป็น RAW
local githubURL = "https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/KillForAutoFarm.lua"
local githubURL2 = "https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Ka1t.lua"

local function loadFromGitHub()
    local success, result = pcall(function()
        return loadstring(game:HttpGet(githubURL))()
    end)

    local function loadFromGitHub2()
    local success, result = pcall(function()
        return loadstring(game:HttpGet(githubURL2))()
    end)

    if success then
        print("Script loaded successfully from GitHub.")
    else
        warn("Failed to load script:", result)
    end
end

local function onDeath()
    print("Player died. Waiting 5 seconds before loading script...")
    task.delay(5, loadFromGitHub)  -- ดีเลย์ 5 วินาทีก่อนโหลด
end

-- รอตัวละครใหม่เกิด
LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.Died:Connect(onDeath)
    end
end)

-- หากมีตัวละครอยู่แล้ว
if LocalPlayer.Character then
    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Died:Connect(onDeath)
    end
end
