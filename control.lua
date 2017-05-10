-- TOOLS: Recommend all be turned on
--require "locale/utils/event" --Yes this line is seriously commented out, and yes without this it won't even work. I guess you now HAVE TO change the settings to match what you need.
--require "permissions" --Permission manager
--require "trusted" --Module to add trusted players to a seperate permission group
--require "locale/utils/patreon" --Module to give patreons spectate and a nice unique tag
--require "locale/utils/admin"	--Admin module to give the admins spectate, commands and character modifications.
--require "announcements"	--Module to announce stuff ingame / give the players a welcome message
--require "tag" --Module to let players set a tag behind their names to improve teamwork
--require "fmcd" --Module to consolidate saving data to an output file for the agent
--require "stats" --Module to generate stats and print them to the filesystem
--require "popup" --Module to create and display an popup in the center of all players their screens.
--require "rules" --Module which displays a popup with the rules when a player joins, or presses the open rules button
--require "rocket" --Module to stop people removing the rocket silo

-- World Generators: Pick only ONE
--require "void" --Worldgenerator which randomly generates holes in the world
--require "nuclear" --worldgenerator for nuclear scenario
--require "island_spawn" --worldgenerator for island spawn scenario
--require "grid" --Worldgenerator which devides the world into a grid.

--BROKEN?
--require "locale/utils/undecorator"	--Removes decorations

-- FOLLOWING CODE GIVES SAME MINIMUM INVENTORY TO ALL SCENARIOS:

local function ticks_from_minutes(minutes)
	return minutes * 60 * 60
end

-- Give player starting items.
-- @param event on_player_joined event
function player_joined(event)
	local player = game.players[event.player_index]
	if game.tick < ticks_from_minutes(10) then
		player.insert { name = "pistol", count = 1 }
		player.insert { name = "firearm-magazine", count = 20 }
		player.insert { name = "burner-mining-drill", count = 2 }
		player.insert { name = "stone-furnace", count = 2 }
	end

	if (player.force.technologies["steel-processing"].researched) then
        player.insert { name = "steel-axe", count = 2 }
    else
        player.insert { name = "iron-axe", count = 5 }
    end
end

-- Give player weapons after they respawn.
-- @param event on_player_respawned event
function player_respawned(event)
	local player = game.players[event.player_index]

	if (player.force.technologies["military"].researched) then
        player.insert { name = "submachine-gun", count = 1 }
    else
		player.insert { name = "pistol", count = 1 }
    end

	if (player.force.technologies["uranium-ammo"].researched) then
        player.insert { name = "uranium-rounds-magazine", count = 10 }
    else 
		if (player.force.technologies["military-2"].researched) then
			player.insert { name = "piercing-rounds-magazine", count = 10 }
		else
			player.insert { name = "firearm-magazine", count = 10 }
		end
	end
end

Event.register(defines.events.on_player_created, player_joined)
Event.register(defines.events.on_player_respawned, player_respawned)
