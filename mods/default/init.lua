default = {}
local pixels = {}
pixels.colors = {
	{"white"},
	{"grey"},
	{"black"},
	{"red"},
	{"yellow"},
	{"green"},
	{"cyan"},
	{"blue"},
	{"magenta"},
	{"orange"},
	{"violet"},
	{"brown"},
	{"pink"},
	{"dark_grey"},
	{"dark_green"},
	{"saddle_brown"},}
for _, row in ipairs(pixels.colors) do
	local name = row[1]
		minetest.register_on_newplayer(function(player)
			player:get_inventory():add_item('main', 'default:'..name..' 10000')
			player:get_inventory():add_item('main', 'default:'..name..'_framed 10000')
end )
end
minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=1.00, [2]=1.00, [3]=1.00}, uses=0, maxlevel=4},}}})
for _, row in ipairs(pixels.colors) do
	local name = row[1]
	minetest.register_node("default:"..name, {
		description = name.." Pixel",
		tiles = {"pixel_"..name..".png"},
		groups = {cracky=2},
		stack_max = 10000,
		light_source = 4,
		sunlight_propagates = true,
	})
end
for _, row in ipairs(pixels.colors) do
	local name = row[1]
	minetest.register_node("default:"..name.."_framed", {
		description = "Framed (black border)"..name.." Pixel",
		tiles = {"pixel_"..name..".png^pixel_frame.png"},
		groups = {cracky=2},
		stack_max = 10000,
		light_source = 4,
		sunlight_propagates = true,
	})
end
minetest.register_alias("mapgen_air", "air")
minetest.register_alias("mapgen_water_source", "default:dark_grey")
minetest.register_alias("mapgen_stone", "default:dark_grey")
minetest.register_alias("mapgen_dirt", "default:dark_grey")
minetest.register_alias("mapgen_sand", "default:dark_grey")
minetest.register_alias("mapgen_cobble", "default:dark_grey")
minetest.register_alias("mapgen_dirt_with_grass", "default:dark_grey")
minetest.register_alias("mapgen_stone", "default:dark_grey")
minetest.register_alias("mapgen_dirt", "default:dark_grey")
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
	end, })
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
	end, })
