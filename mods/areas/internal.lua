function areas:player_exists(name)
	return minetest.auth_table[name] ~= nil
end
function areas:save()
	local datastr = minetest.serialize(self.areas)
	if not datastr then
		minetest.log("error", "[areas] Failed to serialize area data!")
		return
	end
	local file, err = io.open(self.config.filename, "w")
	if err then
		return err
	end
	file:write(datastr)
	file:close()
end
function areas:load()
	local file, err = io.open(self.config.filename, "r")
	if err then
		self.areas = self.areas or {}
		return err
	end
	self.areas = minetest.deserialize(file:read("*a"))
	if type(self.areas) ~= "table" then
		self.areas = {}
	end
	file:close()
end
local function findFirstUnusedIndex(t)
	local i = 0
	repeat i = i + 1
	until t[i] == nil
	return i
end
function areas:add(owner, name, pos1, pos2, parent)
	local id = findFirstUnusedIndex(self.areas)
	self.areas[id] = {name=name, pos1=pos1, pos2=pos2, owner=owner,
			parent=parent}
	return id
end
function areas:remove(id, recurse)
	if recurse then
		local cids = self:getChildren(id)
		for _, cid in pairs(cids) do
			self:remove(cid, true)
		end
	else
		local parent = self.areas[id].parent
		local children = self:getChildren(id)
		for _, cid in pairs(children) do
			self.areas[cid].parent = parent
		end
	end
	self.areas[id] = nil
end
function areas:isSubarea(pos1, pos2, id)
	local area = self.areas[id]
	if not area then
		return false
	end
	local p1, p2 = area.pos1, area.pos2
	if (pos1.x >= p1.x and pos1.x <= p2.x) and
	   (pos2.x >= p1.x and pos2.x <= p2.x) and
	   (pos1.y >= p1.y and pos1.y <= p2.y) and
	   (pos2.y >= p1.y and pos2.y <= p2.y) and
	   (pos1.z >= p1.z and pos1.z <= p2.z) and
	   (pos2.z >= p1.z and pos2.z <= p2.z) then
		return true
	end
end
function areas:getChildren(id)
	local children = {}
	for cid, area in pairs(self.areas) do
		if area.parent and area.parent == id then
			table.insert(children, cid)
		end
	end
	return children
end
function areas:canPlayerAddArea(pos1, pos2, name)
	local privs = minetest.get_player_privs(name)
	if privs.areas then
		return true
	end
	if not self.config.self_protection or
			not privs[areas.config.self_protection_privilege] then
		return false, "Self protection is disabled or you do not have"
				.." the necessary privilege."
	end
	local max_size = privs.areas_high_limit and
			self.config.self_protection_max_size_high or
			self.config.self_protection_max_size
	if
			(pos2.x - pos1.x) > max_size.x or
			(pos2.y - pos1.y) > max_size.y or
			(pos2.z - pos1.z) > max_size.z then
		return false, "Area is too big."
	end
	local count = 0
	for _, area in pairs(self.areas) do
		if area.owner == name then
			count = count + 1
		end
	end
	local max_areas = privs.areas_high_limit and
			self.config.self_protection_max_areas_high or
			self.config.self_protection_max_areas
	if count >= max_areas then
		return false, "You have reached the maximum amount of"
				.." areas that you are allowed to  protect."
	end
	local can, id = self:canInteractInArea(pos1, pos2, name)
	if not can then
		local area = self.areas[id]
		return false, ("The area intersects with %s [%u] (%s).")
				:format(area.name, id, area.owner)
	end
	return true
end
function areas:toString(id)
	local area = self.areas[id]
	local message = ("%s [%d]: %s %s %s"):format(
		area.name, id, area.owner,
		minetest.pos_to_string(area.pos1),
		minetest.pos_to_string(area.pos2))
	local children = areas:getChildren(id)
	if #children > 0 then
		message = message.." -> "..table.concat(children, ", ")
	end
	return message
end
function areas:sort()
	local sa = {}
	for k, area in pairs(self.areas) do
		if not area.parent then
			table.insert(sa, area)
			local newid = #sa
			for _, subarea in pairs(self.areas) do
				if subarea.parent == k then
					subarea.parent = newid
					table.insert(sa, subarea)
				end
			end
		end
	end
	self.areas = sa
end
function areas:isAreaOwner(id, name)
	local cur = self.areas[id]
	if cur and minetest.check_player_privs(name, self.adminPrivs) then
		return true
	end
	while cur do
		if cur.owner == name then
			return true
		elseif cur.parent then
			cur = self.areas[cur.parent]
		else
			return false
		end
	end
	return false
end
