local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("Lxxuak Hub", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
local tab2 = DrRayLibrary.newTab("Auto Farm", "ImageIdHere")

--loadstring(game:HttpGet(""))()

tab.newToggle("Fast Attack", "Fast Attack", false, function(FastAttack)
    getgenv().FastAttack = FastAttack
    if FastAttack then
        
    end
end)

tab.newButton("ขายทั้งหมด", "ขายของในตัวทั้งหมด", function()
    
end)
