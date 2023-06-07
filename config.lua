-- parse disabled libs
local t = string.split(minetest.settings:get(
		'mooncontroller_libs.disabled_libs') or 'worldedit', ',')

for _, s in ipairs(t) do

	mooncontroller_libs.disabled_libs[s] = true

end

