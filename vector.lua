local mcls = mooncontroller_libs

if not mcls.is_lib_disabled('vector') then

	mooncontroller.luacontroller_libraries['vector'] = vector

end -- if not disabled vector


if not mcls.is_lib_disabled('vector_basic') then

local tV = {}
tV.new = function(x, y, z, r)
	return { x = x or 0, y = y or 0, z = z or 0, r = r }
end
tV.copy = function(v)
print(type(v))
	if 'table' ~= type(v) then return tV.new() end
	return { x = v.x, y = v.y, z = v.z, r = v.r }
end

mooncontroller.luacontroller_libraries['vector_basic'] = tV

end -- if not disabled vector_basic

