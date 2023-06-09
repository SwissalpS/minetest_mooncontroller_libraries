local tS = {}

tS.split = function(s, sep)

	if 'string' ~= type(s)
		or 'string' ~= type(sep)
		or '' = sep then return nil end

	local t = {}

	-- TODO:

	return t

end -- split


mooncontroller.luacontroller_libraries['string'] = tS

