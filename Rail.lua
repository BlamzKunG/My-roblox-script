local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("Lxxuak Hub", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
local tab2 = DrRayLibrary.newTab("Esp", "ImageIdHere")

tab.newToggle("Kill All", "Kill All", false, function(toggleState)
    if toggleState then
        print("On")
    else
        print("Off")
    end
end)

tab2.newToggle("Esp", "Esp", false, function(toggleState)
    if toggleState then
        print("On")
    else
        print("Off")
    end
end)
