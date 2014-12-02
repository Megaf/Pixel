default = {}

	print("HELLO WORLD")
--[[
minetest.register_on_newplayer(function(player)
	player:get_inventory():add_item('main', 'default:dirt_with_grass 10000')
end) ]]

local pixels = {}
pixels.colors = {
	{"white",      "White",      nil},
	{"grey",       "Grey",       "basecolor_grey"},
	{"black",      "Black",      "basecolor_black"},
	{"red",        "Red",        "basecolor_red"},
	{"yellow",     "Yellow",     "basecolor_yellow"},
	{"green",      "Green",      "basecolor_green"},
	{"cyan",       "Cyan",       "basecolor_cyan"},
	{"blue",       "Blue",       "basecolor_blue"},
	{"magenta",    "Magenta",    "basecolor_magenta"},
	{"orange",     "Orange",     "excolor_orange"},
	{"violet",     "Violet",     "excolor_violet"},
	{"brown",      "Brown",      "unicolor_dark_orange"},
	{"pink",       "Pink",       "unicolor_light_red"},
	{"dark_grey",  "Dark Grey",  "unicolor_darkgrey"},
	{"dark_green", "Dark Green", "unicolor_dark_green"},
}

for _, row in ipairs(pixels.colors) do
	local name = row[1]
	local desc = row[2]
		minetest.register_on_newplayer(function(player)
			player:get_inventory():add_item('main', "pixels:"..name' 10000'),
--			player:get_inventory():add_item('main', "pixels:"..name.."_framed"' 10000'),
		end) 		
	
end

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
})

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

local homes_file = minetest.get_worldpath() .. "/homes"
local homepos = {}

local function loadhomes()
	local input = io.open(homes_file, "r")
	if input then
		repeat
			local x = input:read("*n")
			if x == nil then
				break
			end
			local y = input:read("*n")
			local z = input:read("*n")
			local name = input:read("*l")
			homepos[name:sub(2)] = {x = x, y = y, z = z}
		until input:read(0) == nil
		io.close(input)
	else
		homepos = {}
	end
end

loadhomes()
local changed = false

minetest.register_chatcommand("home", {
	description = "Type /home to teleport yourself to your land.",
	privs = {interact=true},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if player == nil then
			return false
		end
		if homepos[player:get_player_name()] then
			player:setpos(homepos[player:get_player_name()])
			minetest.chat_send_player(name, "You have been teleported to your area.")
		else
			minetest.chat_send_player(name, "Type /sethome to save the place where you are, allowing you to teleport back to it later on.")
		end
	end,
})

minetest.register_chatcommand("sethome", {
		description = "Type /sethome to save the place where you are, allowing you to teleport back to it later on.",
		privs = {interact=true},
		func = function(name)
		local player = minetest.get_player_by_name(name)
		local pos = player:getpos()
		homepos[player:get_player_name()] = pos
		minetest.chat_send_player(name, "Your position have been recorded.")
		changed = true
		if changed then
			local output = io.open(homes_file, "w")
			for i, v in pairs(homepos) do
				output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
			end
			io.close(output)
			changed = false
		end
	end,
})


--dofile(minetest.get_modpath("default").."/file.lua")
--[[ minetest.register_on_joinplayer(function(player)
	local cb = function(player)
		minetest.chat_send_player(player:get_player_name(), "Text")
	end
	minetest.after(2.0, cb, player)
end) ]]
--minetest.register_privilege("priv", "description")


