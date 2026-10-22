--!strict

local builders = require("../../luau_packages/builders")
local classes = require("../../luau_packages/classes")

local uptime = require("../utils/getUptime")
local parseSeconds = require("../utils/parseSeconds")

return {
	command = builders.interaction.interaction
		.new()
		:setName("about")
		:setDescription("About Yue")
		:addIntegrationType("GuildInstall")
		:addContext("Guild")
		:build(),

	execute = function(interaction: classes.TypesCommand)
		local embed = builders.embed.embed
			.new()
			:setTitle("About Yue 🌙")
			:setDescription(
				'Yue (月 - Yuè) — meaning moon in Chinese — is a Discord bot made for helping moderators and admins keep their server safe.\n\nYue is written in Luau, a language based on Lua, meaning "moon" in Portuguese, hence the name Yue.\n\nThis is yet another side project by <@360235359746916352> (zhai_), this time as a way to learn Luau and pave the road for learning to program Roblox games.'
			)
			:setColor(0xfbff00)
			:addField(
				builders.embed.field
					.new()
					:setName("Uptime")
					:setValue(`\`{parseSeconds.SecondsToClock(os.time() - uptime.getUptime())}\``)
					:setIsInline(true)
			)
			:addField(
				builders.embed.field
					.new()
					:setName("Memory Usage")
					:setValue(`\`{string.format("%.2f", gcinfo() / 1024)}MB\``)
					:setIsInline(true)
			)
			:setFooter({ text = "Yue - made with ❤️" })

		interaction:messageAsync(builders.message.message.new():addEmbed(embed):build()):await()
	end,
}
