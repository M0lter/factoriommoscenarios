-- Give players the option to set their preferred role as a tag
-- A 3Ra Gaming creation
-- Modified by I_IBlackI_I

function tag_create_gui(event)
	local player = game.players[event.player_index]
	if player.gui.top.tag == nil then
		player.gui.top.add { name = "rules_tag", type = "button", caption = "Tag" }
	end
end

-- Tag list
global.tag = global.tag or {}
global.tag.tags = {
	{ display_name = "Mining" },
	{ display_name = "Oil" },
	{ display_name = "Bus" },
	{ display_name = "Smelting" },
	{ display_name = "Pest Control" },
	{ display_name = "Automation" },
	{ display_name = "Quality Control" },
	{ display_name = "Power" },
	{ display_name = "Trains" },
	{ display_name = "Science" },
	{ display_name = "Robotics"},
	{ display_name = "AFK" },
	{ display_name = "Clear" }
}

function tag_expand_gui(player)
	local frame = player.gui.left["tag-panel"]
	if (frame) then
		frame.destroy()
	else
		local frame = player.gui.left.add { type = "frame", name = "tag-panel", caption = "Choose Tag" }
		for _, role in pairs(global.tag.tags) do
			frame.add { type = "button", caption = role.display_name, name = "rules_" .. role.display_name }
		end
	end
end



function tag_on_gui_click(event)
	if not (event and event.element and event.element.valid) then return end
	local player = game.players[event.element.player_index]
	local name = event.element.name
	if (name == "rules_tag") then
		tag_expand_gui(player)
	end

	if (name == "rules_Clear") then
		player.tag = ""
		tag_expand_gui(player)
		return
	end
	
	for _, role in pairs(global.tag.tags) do
		if (name == "rules_" .. role.display_name) then
			player.tag = "[" .. role.display_name .. "]"
			tag_expand_gui(player)
		end
	end
end


Event.register(defines.events.on_gui_click, tag_on_gui_click)
Event.register(defines.events.on_player_joined_game, tag_create_gui)
