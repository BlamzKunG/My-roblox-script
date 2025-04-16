local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("Lxxuak Hub", "Default")
local tab = DrRayLibrary.newTab("Main", "ImageIdHere")

tab.newToggle("Hitbox Expand", "Head Hitbox Expand", false, function(toggleState)
    if toggleState then
        print("On")
    else
        print("Off")
    end
end)
