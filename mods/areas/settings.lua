local world_path = minetest.get_worldpath()
areas.config = {}
local function setting(tp, name, default)
	local full_name = "areas."..name
	local value
	if tp == "boolean" then
		value = minetest.setting_getbool(full_name)
	elseif tp == "string" then
		value = minetest.setting_get(full_name)
	elseif tp == "position" then
		value = minetest.setting_get_pos(full_name)
	elseif tp == "number" then
		value = tonumber(minetest.setting_get(full_name))
	else
		error("Invalid setting type!")
	end
	if value == nil then
		value = default
	end
	areas.config[name] = value
end
setting("string", "filename", world_path.."/areas.dat")
setting("boolean",  "self_protection", false)
setting("string",   "self_protection_privilege", "interact")
setting("position", "self_protection_max_size",      {x=64,  y=128, z=64})
setting("number",   "self_protection_max_areas",      4)
setting("position", "self_protection_max_size_high", {x=512, y=512, z=512})
setting("number",   "self_protection_max_areas_high", 32)
