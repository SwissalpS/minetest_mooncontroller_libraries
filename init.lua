mooncontroller_libs = {
	version = 20230606.0048,
	disabled_libs = {},
	base_path = minetest.get_modpath('mooncontroller_libs')
}

-- base path
local sMP = mooncontroller_libs.base_path

dofile(sMP .. '/config.lua')
dofile(sMP .. '/utils.lua')
local doif = mooncontroller_libs.dofile_if_enabled
doif('date_time')
doif('dump2')
doif('log')
doif('string')
doif('table')
doif('technic_materials')
doif('vector')
doif('vector_basic')
doif('worldedit')

