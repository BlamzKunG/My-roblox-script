local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local PLACE_ID = game.PlaceId
local CHECK_INTERVAL = 5
local CURRENT_JOB_ID = game.JobId

-- ดึงรายชื่อ Server จาก Public API ของ Roblox
local function getPublicServers()
	local servers = {}
	local cursor = ""
	local url = ("https://games.roblox.com/v1/games/%d/servers/Public?limit=100"):format(PLACE_ID)

	local success, result = pcall(function()
		return HttpService:JSONDecode(game:HttpGet(url .. "&cursor=" .. cursor))
	end)

	if success and result and result.data then
		for _, server in pairs(result.data) do
			if server.playing < server.maxPlayers and server.id ~= CURRENT_JOB_ID then
				table.insert(servers, server.id)
			end
		end
	end

	return servers
end

-- ตรวจสอบจำนวนผู้เล่น
while true do
	local playerCount = #Players:GetPlayers()

	if playerCount <= 3 then
		local servers = getPublicServers()
		
		if #servers > 0 then
			local chosenServer = servers[math.random(1, #servers)]
			TeleportService:TeleportToPlaceInstance(PLACE_ID, chosenServer)
		else
			warn("ไม่พบ Server ที่สามารถเข้าได้")
		end
		
		break
	end

	wait(CHECK_INTERVAL)
end
