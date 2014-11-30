default = {}

	print("HELLO WORLD")

minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 0,
		groupcaps = {
			fleshy = {times={[2]=2.00, [3]=1.00}, uses=0, maxlevel=1},
			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=7.00,[2]=4.00,[3]=1.40}, uses=0, maxlevel=3},
		}
	}
})

minetest.register_node("default:stone", {
	description = "Stone",
	tiles ={"default_stone.png"},
	groups = {cracky=3},
	drop = 'default:cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})
--[[
minetest.register_node("default:stone_with_coal", {
	description = "Stone with coal",
	tiles ={"default_stone.png^default_mineral_coal.png"},
	groups = {cracky=3},
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_iron", {
	description = "Stone with iron",
	tiles ={"default_stone.png^default_mineral_iron.png"},
	groups = {cracky=3},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})
]]
minetest.register_node("default:dirt_with_grass", {
	description = "Dirt with grass",
	tiles ={"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	groups = {crumbly=3, soil=1},
	drop = 'default:dirt',
	}),
})

minetest.register_node("default:nyancat", {
	description = "Nyancat",
	tiles ={"default_nc_side.png", "default_nc_side.png", "default_nc_side.png",
		"default_nc_side.png", "default_nc_back.png", "default_nc_front.png"},
	inventory_image = "default_nc_front.png",
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_defaults(),
})

minetest.register_node("default:nyancat_rainbow", {
	description = "Nyancat Rainbow",
	tiles ={"default_nc_rb.png"},
	inventory_image = "default_nc_rb.png",
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_alias("mapgen_air", "air")
minetest.register_alias("mapgen_stone", "default:dirt_with_grass")
minetest.register_alias("mapgen_dirt", "default:dirt_with_grass")
minetest.register_alias("mapgen_sand", "default:dirt_with_grass")
minetest.register_alias("mapgen_cobble", "default:dirt_with_grass")
minetest.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("mapgen_stone", "default:dirt_with_grass")
minetest.register_alias("mapgen_dirt", "default:dirt_with_grass")

--dofile(minetest.get_modpath("default").."/mapgen.lua")
--[[ minetest.register_on_joinplayer(function(player)
	local cb = function(player)
		minetest.chat_send_player(player:get_player_name(), "This is the [minimal] \"Minimal Development Test\" game. Use [minetest_game] for the real thing.")
	end
	minetest.after(2.0, cb, player)
end) ]]


