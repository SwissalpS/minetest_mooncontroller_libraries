mooncontroller_libs.is_lib_disabled = function(s)

	return not not mooncontroller_libs.disabled_libs[s]

end -- is_lib_disabled


local sMP = mooncontroller_libs.base_path
mooncontroller_libs.dofile_if_enabled = function(s)

	if mooncontroller_libs.disabled_libs[s] then return end

	return dofile(sMP .. '/modules/' .. s .. '.lua')

end -- dofile_if_enabled


mooncontroller_libs.table_keys = function(t)

	local i, l = 0, {}
	for k, _ in pairs(t) do
		i = i + 1
		l[i] = k
	end

	table.sort(l)
	return l

end -- table_keys

