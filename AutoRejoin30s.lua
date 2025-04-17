local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TARGET_USERNAME = "A_ABadLorena" -- ไม่ต้องใส่ @
local GAME_ID = game.PlaceId
local WAIT_TIME_BEFORE_REJOIN = 30

-- Function: รีจอยไป Server ที่คนเยอะที่สุด (ไม่นับ Server ปัจจุบัน)
local function getServerWithMostPlayers()
    local servers = {}
    local cursor = ""

    repeat
        local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&cursor=%s", GAME_ID, cursor)
        local success, response = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)

        if success and response and response.data then
            for _, server in ipairs(response.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(servers, server)
                end
            end
            cursor = response.nextPageCursor or ""
        else
            warn("โหลดลิสต์เซิร์ฟเวอร์ล้มเหลว")
            break
        end

        task.wait(0.5)
    until cursor == nil or cursor == ""

    table.sort(servers, function(a, b)
        return a.playing > b.playing
    end)

    return servers[1]
end

-- Function: รีจอยไปยัง Server ที่ระบุ
local function teleportToServer(serverId)
    TeleportService:TeleportToPlaceInstance(GAME_ID, serverId, LocalPlayer)
end

-- Function: รีจอยทันทีถ้าพบผู้เล่นเป้าหมาย
local function checkForTargetAndRejoin()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name == TARGET_USERNAME or player.DisplayName == TARGET_USERNAME then
            print("พบ " .. TARGET_USERNAME .. " รีจอยทันที")
            task.wait(0.5)
            local bestServer = getServerWithMostPlayers()
            if bestServer then
                teleportToServer(bestServer.id)
            end
            return
        end
    end
end

-- ตรวจสอบเป้าหมายทุกครั้งมีผู้เล่นเข้าใหม่
Players.PlayerAdded:Connect(function(player)
    if player.Name == TARGET_USERNAME or player.DisplayName == TARGET_USERNAME then
        checkForTargetAndRejoin()
    end
end)

-- เช็กตอนเริ่มต้นเผื่อเจออยู่แล้ว
checkForTargetAndRejoin()

-- ถ้ายังไม่เจอ รอ 30 วิ แล้วรีจอยตามปกติ
task.wait(WAIT_TIME_BEFORE_REJOIN)
local bestServer = getServerWithMostPlayers()
if bestServer then
    teleportToServer(bestServer.id)
end
