local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- ฟังก์ชัน deobfuscate สำหรับสร้างข้อความจากตัวเลข ASCII
local function deobfuscate(arr)
    local str = ""
    for _, code in ipairs(arr) do
        str = str .. string.char(code)
    end
    return str
end

-- สร้างชื่อ Event แบบออบฟัส
local remoteEventName = deobfuscate({75,105,108,108,69,118,101,110,116})       -- "KillEvent"
local damageEventName = deobfuscate({68,97,109,97,103,101,69,118,101,110,116})      -- "DamageEvent"

---------------------------
-- Kill Method Functions
---------------------------

local function killWithRemoteEvent(player)
    local remoteEvent = ReplicatedStorage:FindFirstChild(remoteEventName)
    if remoteEvent then
        remoteEvent:FireServer(player)
        print("[RemoteEvent] คำสั่งฆ่า " .. player.Name)
    end
end

local function killWithDamageEvent(player)
    local damageEvent = ReplicatedStorage:FindFirstChild(damageEventName)
    if damageEvent then
        damageEvent:FireServer(player, math.huge)
        print("[DamageEvent] ส่งความเสียหายมหาศาลให้ " .. player.Name)
    end
end

local function killWithHealthZero(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
        print("[Health=0] ตั้งค่า Health เป็น 0 สำหรับ " .. player.Name)
    end
end

local function killWithTakeDamage(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:TakeDamage(math.huge)
        print("[TakeDamage] ใช้ TakeDamage ให้ " .. player.Name)
    end
end

local function killWithBreakJoints(player)
    if player.Character then
        player.Character:BreakJoints()
        print("[BreakJoints] ทำลาย joints ของ " .. player.Name)
    end
end

local function killWithChangeState(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
        print("[ChangeState] เปลี่ยนสถานะเป็น Dead สำหรับ " .. player.Name)
    end
end

local function killWithDestroyHumanoid(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:Destroy()
        print("[DestroyHumanoid] ทำลาย Humanoid ของ " .. player.Name)
    end
end

local function killWithExplosion(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local explosion = Instance.new("Explosion")
        explosion.Position = player.Character.HumanoidRootPart.Position
        explosion.BlastPressure = 500000
        explosion.BlastRadius = 10
        explosion.Parent = Workspace
        print("[Explosion] สร้าง Explosion ใกล้ " .. player.Name)
    end
end

local function killWithDestroyCharacter(player)
    if player.Character then
        player.Character:Destroy()
        print("[DestroyCharacter] ทำลาย Character ของ " .. player.Name)
    end
end

---------------------------
-- Ultimate Force Kill Function for One Player
---------------------------
local function ultimateForceKill(player)
    if player == Players.LocalPlayer then return end
    -- เรียกใช้ทุกวิธีพร้อมกัน (ใช้ spawn เพื่อให้ทำงานแบบขนาน)
    spawn(function() killWithRemoteEvent(player) end)
    spawn(function() killWithDamageEvent(player) end)
    spawn(function() killWithHealthZero(player) end)
    spawn(function() killWithTakeDamage(player) end)
    spawn(function() killWithBreakJoints(player) end)
    spawn(function() killWithChangeState(player) end)
    spawn(function() killWithDestroyHumanoid(player) end)
    spawn(function() killWithExplosion(player) end)
    spawn(function() killWithDestroyCharacter(player) end)
end

-- Ultimate Kill All: ใช้ ultimateForceKill กับผู้เล่นทุกคน (ยกเว้น LocalPlayer)
local function ultimateKillAll()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            ultimateForceKill(player)
        end
    end
    print("Ultimate Kill All ถูกเรียกใช้สำหรับผู้เล่นทุกคน")
end

---------------------------
-- UI Setup: Single Button
---------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateKillAllUI"
screenGui.Parent = game.CoreGui

local button = Instance.new("TextButton")
button.Name = "UltimateKillAllButton"
button.Parent = screenGui
button.Text = "Kill All"
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 24

button.MouseEnter:Connect(function()
    button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
end)
button.MouseLeave:Connect(function()
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end)

button.MouseButton1Click:Connect(function()
    ultimateKillAll()
end)

-- เพิ่ม Keybind: กด "K" เพื่อเรียก Ultimate Kill All
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        ultimateKillAll()
    end
end)

print("Ultimate Kill All – Single Button UI loaded. กดปุ่มหรือกด K เพื่อเรียกใช้ Kill All")
