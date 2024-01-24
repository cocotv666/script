repeat task.wait() until game:IsLoaded()

local BlacklistedUsers = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlSploit/AlSploit/main/Blacklist"))()
local RobloxHardWareId = game:GetService("RbxAnalyticsService"):GetClientId()
local LocalPlayer = game.Players.LocalPlayer

task.spawn(function()
	for i, v in next, BlacklistedUsers do
		if v == RobloxHardWareId then
			task.spawn(function()
				LocalPlayer:Kick("You are blacklisted from AlSploit. For support, contact godclutcher or join the discord (discord.gg/AlSploit)")
			end)

			task.spawn(function()
				shared.AlSploitLoaded = false
			end)

			task.spawn(function()
				task.wait(10)

				game:shutdown()
			end)			
		end

		if v ~= RobloxHardWareId then
			shared.AlSploitLoaded = true

			loadstring(game:HttpGet("https://raw.githubusercontent.com/cocotv666/script/main/Coco_Alsploit_Config_MainScript"))()
		end
	end
end)
