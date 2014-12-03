default = {}
	print("Hello human, how are you today?")
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
	{"dark_green"},}
for _, row in ipairs(pixels.colors) do
	local name = row[1]
		minetest.register_on_newplayer(function(player)
			player:get_inventory():add_item('main', 'pixels:'..name..' 10000')
			player:get_inventory():add_item('main', 'pixels:'..name..'_framed 10000')
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
			fleshy = {times={[1]=1.00, [2]=1.00, [3]=1.00}, uses=0, maxlevel=4},
			crumbly = {times={[1]=1.00, [2]=1.00, [3]=1.00}, uses=0, maxlevel=4},
			snappy = {times={[1]=1.00, [2]=1.00, [3]=1.00}, uses=0, maxlevel=4},
			cracky = {times={[1]=1.00, [2]=1.00, [3]=1.00}, uses=0, maxlevel=4},
			oddly_breakable_by_hand = {times={[1]=1.00,[2]=1.00,[3]=1.00}, uses=0, maxlevel=4},
		}}})
minetest.register_alias("mapgen_air", "air")
minetest.register_alias("mapgen_water_source", "pixels:dark_grey")
minetest.register_alias("mapgen_stone", "pixels:dark_grey")
minetest.register_alias("mapgen_dirt", "pixels:dark_grey")
minetest.register_alias("mapgen_sand", "pixels:dark_grey")
minetest.register_alias("mapgen_cobble", "pixels:dark_grey")
minetest.register_alias("mapgen_dirt_with_grass", "pixels:dark_grey")
minetest.register_alias("mapgen_stone", "pixels:dark_grey")
minetest.register_alias("mapgen_dirt", "pixels:dark_grey")
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
minetest.register_on_joinplayer(function(player)
	local cb = function(player)
		minetest.chat_send_player(player:get_player_name(), "Hello sir player. Welcome to this creative game, your objective is make stuff.")
	end
	minetest.after(2.0, cb, player)
end)
