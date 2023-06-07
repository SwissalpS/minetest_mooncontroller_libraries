mooncontroller_libs = {
	version = 20230606.0048,
	disabled_libs = {}
}

-- base path
local sMP = minetest.get_modpath('mooncontroller_libs')

dofile(sMP .. '/config.lua')
dofile(sMP .. '/utils.lua')
dofile(sMP .. '/vector.lua')
dofile(sMP .. '/technic_materials.lua')

