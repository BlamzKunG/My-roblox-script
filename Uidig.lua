local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("Lxxuak Hub", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
local tab2 = DrRayLibrary.newTab("Auto Farm", "ImageIdHere")

--loadstring(game:HttpGet(""))()

tab.newToggle("Fast Attack", "Fast Attack", false, function(AutoFarm)
    getgenv().AutoFarm = AutoFarm
    if AutoFarm then
        getgenv().AutoFarm = true

task.spawn(function()
    while getgenv().AutoFarm do
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("GemEvent"):FireServer(1000)
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DigEvent"):FireServer()
        end)
        task.wait() -- แทบจะรัว 60fps
    end
end)
    end
end)

tab.newButton("ขายทั้งหมด", "ขายของในตัวทั้งหมด", function()
    local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
hrp.CFrame = hrp.CFrame * CFrame.new(0, -407, 0)
end)
