local pixels = {}
pixels.colors = {
	{"white",      "White"},
	{"grey",       "Grey"},
	{"black",      "Black"},
	{"red",        "Red"},
	{"yellow",     "Yellow"},
	{"green",      "Green"},
	{"cyan",       "Cyan"},
	{"blue",       "Blue"},
	{"magenta",    "Magenta"},
	{"orange",     "Orange"},
	{"violet",     "Violet"},
	{"brown",      "Brown"},
	{"pink",       "Pink"},
	{"dark_grey",  "Dark Grey"},
	{"dark_green", "Dark Green"},
}

for _, row in ipairs(pixels.colors) do
	local name = row[1]
	local desc = row[2]
	minetest.register_node("pixels:"..name, {
		description = desc.." Pixel",
		tiles = {"pixel_"..name..".png"},
		groups = {cracky=3,oddly_breakable_by_hand=3},
		stack_max = 10000,
		sunlight_propagates = true,
	})
end

for _, row in ipairs(pixels.colors) do
	local name = row[1]
	local desc = row[2]
	minetest.register_node("pixels:"..name.."_framed", {
		description = "Framed (black border)"..desc.." Pixel",
		tiles = {"pixel_"..name..".png^pixel_frame.png"},
		groups = {cracky=3,oddly_breakable_by_hand=3},
		stack_max = 10000,
		sunlight_propagates = true,
	})
end
