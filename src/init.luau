--!strict

local discord = require("@self/../luau_packages/discord")
local builders = require("@self/../luau_packages/builders")
local commands = require("@self/../luau_packages/commands")

-- count uptime
local uptime = require("@self/utils/getUptime")
uptime.start(os.time())

-- env
local env = require("@self/../.env")

local DISCORD_BOT_INTENTS = builders.intents
	.new({
		"Guilds",
		"GuildMessages",
		"MessageContent",
	})
	:build()

local bot = discord.bot.new({
	token = env.DISCORD_BOT_TOKEN,
	intents = DISCORD_BOT_INTENTS,
	reconnect = true,
})

local commandsManager = commands.new(bot)

local presence = builders.presence
	.new()
	:setStatus("Idle")
	:addActivity(builders.activity.new():setActivityName("hi"):setActivityType("Game"):build())
	:build()

bot.onAllShardsReady:listenOnce(function()
	commandsManager:load("src/commands")
	commandsManager:registerAsync():await()

	print(`{bot.user.username}#{bot.user.discriminator} ({bot.user.id}) is now ready!`)
end)

bot:connectAsync():await()
bot:setPresenceAsync(presence):await()
