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
	{"saddle_brown"},
}
for _, row in ipairs(pixels.colors) do
	local name = row[1]
	minetest.register_node("pixels:"..name, {
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
	minetest.register_node("pixels:"..name.."_framed", {
		description = "Framed (black border)"..name.." Pixel",
		tiles = {"pixel_"..name..".png^pixel_frame.png"},
		groups = {cracky=2},
		stack_max = 10000,
		light_source = 4,
		sunlight_propagates = true,
	})
end
