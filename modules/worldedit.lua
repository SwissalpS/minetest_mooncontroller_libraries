-- nothing for live servers, just playing around with the limits
-- of libraries with this module.
-- No protection checks and no inventory usage and probably going
-- to time-out before anything useful is built.

local function build_cube(tW)

	if not tW.pos or not tW.radius then return nil end

	local tNode = 'table' == type(tW.node) and tW.node or { name = 'default:dirt' }
	local iThickness = tW.thickness and math.min(tW.thickness, tW.radius) or 1
	local iR = tW.radius
	local tP1, tP2, x, y, z

	repeat
		tP1 = vector.add(tW.pos, -iR)
		tP2 = vector.add(tW.pos, iR)
		-- wall 1 & 2
		x = tP1.x
		repeat
			y = tP1.y
			repeat
				minetest.set_node(vector.new(x, y, tP1.z), tNode)
				minetest.set_node(vector.new(x, y, tP2.z), tNode)
				y = y + 1
			until y > tP2.y
			x = x + 1
		until x > tP2.x
		-- walls 3, 4, 5 & 6
		x = tP1.x
		repeat
			z = tP1.z
			repeat
				minetest.set_node(vector.new(x, tP1.y, z), tNode)
				minetest.set_node(vector.new(x, tP2.y, z), tNode)
				minetest.set_node(vector.new(tP1.x, x - tP1.x + tP1.y, z), tNode)
				minetest.set_node(vector.new(tP2.x, x - tP1.x + tP1.y, z), tNode)
				z = z + 1
			until z > tP2.z
			x = x + 1
		until x > tP2.x
		iR = iR - 1
		iThickness = iThickness - 1
	until 0 == iThickness

	return true

end -- build_cube


local function build_sphere() --tW)

	-- TODO

end -- build_sphere


local function build(tW)

	if not tW.name then return nil end

	if 'sphere' == tW.name then
		return build_sphere(tW)

	elseif 'cube' == tW.name then
		return build_cube(tW)

	end

end -- build


local function give_function(tW)

	if not tW.name then return function() end end

	if 'set_node' == tW.name then

		return function(pos, node)
			return minetest.set_node(pos, node)
		end

	elseif 'get_node' == tW.name then

		return function(pos)
			return minetest.get_node(pos)
		end

	end

end -- give_function


local function luaC_worldedit(tW)

	if 'table' ~= type(tW) then return nil end

	if 'function' == tW.command then
		return give_function(tW)

	elseif 'build' == tW.command then
		return build(tW)

	end

	return nil

end -- worldedit


mooncontroller.luacontroller_libraries['worldedit'] = function()--env, pos)

	return luaC_worldedit



end -- add library

