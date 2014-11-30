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
			fleshy = {times={[1]=0.05, [2]=0.05, [3]=0.05}, uses=0, maxlevel=4},
			crumbly = {times={[1]=0.05, [2]=0.05, [3]=0.05}, uses=0, maxlevel=4},
			snappy = {times={[1]=0.05, [2]=0.05, [3]=0.05}, uses=0, maxlevel=4},
			cracky = {times={[1]=0.05, [2]=0.05, [3]=0.05}, uses=0, maxlevel=4},
			oddly_breakable_by_hand = {times={[1]=0.05,[2]=0.05,[3]=0.05}, uses=0, maxlevel=4},
			}
		}
}),

minetest.register_node("default:dirt_with_grass", {
	description = "Dirt with grass",
	tiles ={"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	groups = {crumbly=3, soil=1},
	drop = 'default:dirt_with_grass',
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
})

minetest.register_node("default:nyancat_rainbow", {
	description = "Nyancat Rainbow",
	tiles ={"default_nc_rb.png"},
	inventory_image = "default_nc_rb.png",
	is_ground_content = false,
	groups = {cracky=2},
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


