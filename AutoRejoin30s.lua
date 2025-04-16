local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local function getMostPopulatedServer()
    local placeId = game.PlaceId
    local servers = {}
    local cursor = ""
    local mostPlayers = 0
    local bestServerId = nil

    repeat
        local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Desc&limit=100" .. (cursor ~= "" and "&cursor="..cursor or "")
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)

        if success and result and result.data then
            for _, server in ipairs(result.data) do
                local playerCount = server.playing
                if playerCount > mostPlayers and playerCount < server.maxPlayers then
                    mostPlayers = playerCount
                    bestServerId = server.id
                end
            end
            cursor = result.nextPageCursor
        else
            warn("ไม่สามารถดึงข้อมูลเซิร์ฟเวอร์ได้")
            break
        end
    until not cursor

    return bestServerId
end

-- รอ 30 วินาที
task.wait(30)

-- ค้นหา server แล้วเทเลพอร์ต
local bestServerId = getMostPopulatedServer()
if bestServerId then
    TeleportService:TeleportToPlaceInstance(game.PlaceId, bestServerId, Players.LocalPlayer)
else
    warn("ไม่พบเซิร์ฟเวอร์ที่เหมาะสมสำหรับการเข้าร่วม")
end
