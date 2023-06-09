local tV = {}

-- vector1, vector2 or vector, number
tV.add = function(v, m)

	if 'table' == type(m) then
		return tV.new(
			v.x + m.x,
			v.y + m.y,
			v.z + m.z)

	else
		return tV.new(
			v.x + m,
			v.y + m,
			v.z + m)
	end

end -- add

-- return a copy of vector including radius if given
tV.copy = function(v)

	if 'table' ~= type(v) then return tV.new() end
	return { x = v.x, y = v.y, z = v.z, r = v.r }

end -- copy

-- vector1, vector2
tV.distance = function(a, b)

	local x = a.x - b.x
	local y = a.y - b.y
	local z = a.z - b.z
	return math.sqrt(x * x + y * y + z * z)

end -- distance

-- vector1, vector2
tV.equals = function(a, b)

	return a.x == b.x and a.y == b.y and a.z == b.z

end -- equals

-- check if two cubes intersect giving position and radius
-- vector1, radius1, vector2, radius2
tV.intersect = function(tPa, iRa, tPb, iRb)

	local tA1 = vector.subtract(tPa, iRa)
	local tA2 = vector.add(tPa, iRa)
	local tB1 = vector.subtract(tPb, iRb)
	local tB2 = vector.add(tPb, iRb)

	local bX = (tB1.x <= tA2.x and tB1.x >= tA1.x)
		or (tB2.x <= tA2.x and tB2.x >= tA1.x)

	local bY = (tB1.y <= tA2.y and tB1.y >= tA1.y)
		or (tB2.y <= tA2.y and tB2.y >= tA1.y)

	local bZ = (tB1.z <= tA2.z and tB1.z >= tA1.z)
		or (tB2.z <= tA2.z and tB2.z >= tA1.z)

	return bX and bY and bZ

end -- intersect

-- return a new vector all arguments are optional
-- if no arguments are passed, acts like vector.zero
tV.new = function(x, y, z, r)

	return { x = x or 0, y = y or 0, z = z or 0, r = r }

end -- new

-- returns two vectors first with smaller values,
-- second with the larger values
-- vector1, vector2
tV.sort = function(a, b)

	return tV.new(math.min(a.x, b.x), math.min(a.y, b.y), math.min(a.z, b.z)),
		tV.new(math.max(a.x, b.x), math.max(a.y, b.y), math.max(a.z, b.z))

end -- sort

-- subtracts vector2 from vector1 or subtracts number from each axis
-- vector1, vector2 or vector1, number
tV.subtract = function(v, m)

	if 'table' == type(m) then
		return tV.new(
			v.x - m.x,
			v.y - m.y,
			v.z - m.z)

	else
		return tV.new(
			v.x - m,
			v.y - m,
			v.z - m)
	end

end -- subtract

-- returns a string of vector
-- vector, optional separator string
tV.tostring = function(v, s)

	if (not v) or (not 'table' == type(v))
		or (not v.x) or (not v.y) or (not v.z)
	then
		return 'nil'
	end

	s = s or ' | '
	return tostring(v.x) .. s ..
		tostring(v.y) .. s ..
		tostring(v.z) ..
		(v.r and ' r' .. tostring(v.r) or '')

end -- tostring

mooncontroller.luacontroller_libraries['vector'] = tV
mooncontroller.luacontroller_libraries['vector_env'] = function(env)

	if env.vector then
		error('Field "vector" already exists in env!\nYou should not load ' ..
			'both "vector_core_env" and "vector_env" at the same time.')
	end

	env.vector = tV

	return tV

end

