minetest.register_on_newplayer(function(player)
	player:get_inventory():add_item('main', 'default:dirt_with_grass')
end)

