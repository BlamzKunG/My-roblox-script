local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ใส่ URL GitHub ที่เป็น RAW ได้หลายอัน
local githubURLs = {
    "https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/KillForAutoFarm.lua",
    "https://raw.githubusercontent.com/BlamzKunG/My-roblox-sc/refs/heads/main/Ka1t.lua"
    -- เพิ่ม URL ใหม่ได้ที่นี่
}

-- โหลดสคริปต์จาก GitHub
local function loadScripts()
    for _, url in ipairs(githubURLs) do
        task.spawn(function()
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)

            if success then
                print("Loaded script from:", url)
            else
                warn("Failed to load script from:", url, "\nError:", result)
            end
        end)
    end
end

-- เรียกใช้เมื่อผู้เล่นตาย
local function onDeath()
    print("Player died. Waiting 5 seconds before loading scripts...")
    task.delay(5, loadScripts)
end

-- ผูก event กับการเกิดของตัวละคร
LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.Died:Connect(onDeath)
    end
end)

-- ตรวจสอบหากมีตัวละครอยู่แล้ว
if LocalPlayer.Character then
    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Died:Connect(onDeath)
    end
end
