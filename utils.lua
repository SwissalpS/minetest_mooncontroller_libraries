mooncontroller_libs.is_lib_disabled = function(s)

	return not not mooncontroller_libs.disabled_libs[s]

end -- is_lib_disabled

local sMP = mooncontroller_libs.base_path
mooncontroller_libs.dofile_if_enabled = function(s)

    if mooncontroller_libs.disabled_libs[s] then return end

    return dofile(sMP .. '/' .. s .. '.lua')

end -- dofile_if_enabled

