mooncontroller_libs.is_lib_disabled = function(s)

	return not not mooncontroller_libs.disabled_libs[s]

end -- is_lib_disabled


local sMP = mooncontroller_libs.base_path
mooncontroller_libs.dofile_if_enabled = function(s)

	if mooncontroller_libs.disabled_libs[s] then return end

	return dofile(sMP .. '/modules/' .. s .. '.lua')

end -- dofile_if_enabled


-- replace first occurence of sNeedle in sHaystack with sRep
mooncontroller_libs.string_replace = function(sHaystack, sNeedle, sRep)

	if 'string' ~= type(sHaystack) then return nil end
	if '' == sHaystack then return '' end
	if '' == sNeedle or 'string' ~= type(sNeedle) then
		return sHaystack
	end

	sRep = tostring(sRep) or ''

	local i = string.find(sHaystack, sNeedle, 0, true)
	if not i then return sHaystack end

	return string.sub(sHaystack, 1, i - 1) .. sRep ..
		string.sub(sHaystack, i + string.len(sNeedle))

end -- string_replace


mooncontroller_libs.table_keys = function(t)

	local i, l = 0, {}
	for k, _ in pairs(t) do
		i = i + 1
		l[i] = k
	end

	table.sort(l)
	return l

end -- table_keys

