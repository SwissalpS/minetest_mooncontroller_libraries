-- parse disabled libs
local t = string.split(minetest.settings:get(
		'mooncontroller_libs.disabled_libs') or 'worldedit', ',')

for _, s in ipairs(t) do

	mooncontroller_libs.disabled_libs[s] = true

end

mooncontroller_libs.has_technic = minetest.get_modpath('technic') and true
if not mooncontroller_libs.has_technic then
    mooncontroller_libs.disabled_libs.technic_materials = true
end

