--!strict

local builders = require("../../luau_packages/builders")
local classes = require("../../luau_packages/classes")

return {
	command = builders.interaction.interaction
		.new()
		:setName("kick")
		:setDescription("kick someone")
		:addIntegrationType("GuildInstall")
		:addContext("Guild")
		:addOption(
			builders.interaction.option
				.new()
				:setType("User")
				:setName("target")
				:setDescription("user to kick")
				:setRequired(true)
				:build()
		)
		:addOption(
			builders.interaction.option
				.new()
				:setType("String")
				:setName("reason")
				:setDescription("specify a reason for the kick")
				:setRequired(false)
				:build()
		)
		:build(),

	userPermissions = { "KickMembers" },
	clientPermissions = { "KickMembers" },

	execute = function(interaction: classes.TypesCommand)
		local user = interaction:getMember("target")

		if user == nil then
			interaction
				:messageAsync(
					builders.message.message.new():setContent("The member does not exist somehow."):setFlags("64")
				)
				:await()
			return
		end

		if user.id == interaction.applicationId then
			interaction
				:messageAsync(builders.message.message.new():setContent("You cannot kick me."):setFlags("64"))
				:await()
			return
		end

		local reason = interaction:getString("reason")

		local message = `{user.username} ({user.id})`

		interaction
			:messageAsync(builders.message.message.new():setContent(`Kicking {message}...`):setFlags("64"), true)
			:await()

		user:kickAsync(reason):await()

		interaction:editResponseAsync(
			builders.message.message.new():setContent(`✅ Kicked {message}`):setFlags("64"):build()
		)
	end,
}
