--!strict

local builders = require("../../luau_packages/builders")
local classes = require("../../luau_packages/classes")

local uptime = require("../utils/getUptime")
local parseSeconds = require("../utils/parseSeconds")

return {
	command = builders.interaction.interaction
		.new()
		:setName("about")
		:setDescription("about Yue")
		:addIntegrationType("GuildInstall")
		:addContext("Guild")
		:build(),

	execute = function(interaction: classes.TypesCommand)
		local embed = builders.embed.embed
			.new()
			:setTitle("About Yue 🌙")
			:setDescription([[
			Yue (月 - Yuè) — meaning moon in Chinese — is a Discord bot made for helping the staff keep zhai's cave safe.
			
			Yue is written in Luau, a language based on Lua. Lua means "moon" in Portuguese, hence the name Yue.
				
			This is yet another side project by <@360235359746916352> (zhai_), this time as a way to learn Luau and pave the road for learning to program Roblox games.
			]])
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

	--[[
execute = function(interaction: classes.TypesCommand)
    local components = builders.message.components
    local container = components.container
        .new()
        :setAccentColor(0xfbff00)
        :addComponent(
            components.textDisplay
                .new()
                :setContent("# About Yue 🌙")
                :build()
        )
        :addComponent(
            components.textDisplay
                .new()
                :setContent("
Yue (月 - Yuè) — meaning moon in Chinese — is a Discord bot made to help the staff keep zhai's cave safe.

Yue is written in Luau, a language based on Lua. Lua means "moon" in Portuguese, hence the name Yue.

This is another side project by <@360235359746916352> (zhai_), this time as a way to learn Luau and pave the road for learning to program Roblox games.
                ")
                :build()
        )
        :addComponent(components.separator.new():build())
        :addComponent(
            components.textDisplay
                .new()
                :setContent(
                    `**Uptime** · \`{parseSeconds.SecondsToClock(os.time() - uptime.getUptime())}\`  |  **Memory Usage** · \`{string.format("%.2f", gcinfo() / 1024)}MB\``
                )
                :build()
        )
        :addComponent(components.separator.new():build())
        :addComponent(
            components.textDisplay
                .new()
                :setContent("Yue - made with ❤️")
                :build()
        )
        :build()

    local message = builders.message.message
        .new()
        :setFlags("32768") -- IS_COMPONENTS_V2 (bit 15)
        :addComponent(container)
        :build()

    interaction:messageAsync(message):await()
end,	
	]]
}
