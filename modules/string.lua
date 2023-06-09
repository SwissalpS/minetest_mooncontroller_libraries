local tS = {}
-- TODO: throw errors instead of returning nil?

tS.begins_with = function(sHaystack, sNeedle)
	if '' == sNeedle then return nil end
	return string.sub(sHaystack, 1, string.len(sNeedle)) == sNeedle
end -- begins_with


-- simple find if string contains other string
tS.contains = function(sHaystack, sNeedle)
	if '' == sNeedle then return nil end
	return string.find(sHaystack, sNeedle, 0, true) ~= nil
end -- contains


-- truncate string s to length i and add ellipsis if needed
-- at beginning: b == true (or anything but false and nil)
-- in the middle: b == false
-- at end: b == nil
tS.ellipsis = function(s, i, b)

	-- invalid or too short -> nothing to do
	if 'string' ~= type(s) or string.len(s) <= i then return s end
	if 'number' ~= type(i) then return nil end

	-- we don't want any negativity nor fractions
	i = math.abs(math.floor(i))
	-- silly
	if 0 == i then return '' end

	-- ridiculous
	if 2 >= i then return string.sub(s, 1, i) end

	if nil == b then
		-- add to end
		return string.sub(s, 1, i - 1) .. '…'
	elseif b then
		-- add to beginning
		return '…' .. string.sub(s, -1 * (i - 1))
	else
		-- insert in middle
		local j = math.floor((i - 1) * .5)
		return string.sub(s, 1, j) .. '…' .. string.sub(s, -j)
	end

end -- ellipsis


tS.ends_with = function(sHaystack, sNeedle)
	if '' == sNeedle then return nil end
	return string.sub(sHaystack, -string.len(sNeedle)) == sNeedle
end -- ends_with


-- make a number nice and pretty
-- truncate number n to i decimals and apply prettyness with locale s
-- (defaults to Swiss locale)
--[[
tS.pretty_num = function(n, i, s)

	if 'number' ~= type(n) then return nil end
	if nil == i then i = 99 end
	if 'number' ~= type(i) then return nil end

	-- we don't want to deal with negativity
	i = math.abs(i)

	-- default to CH style
	local sComma, sSep = '.', "'"
	-- allow arbitrary comma and thousand separator
	if 'table' == type(s) then
		sComma, sSep = s[1] or '.', s[2] or "'"
	-- add some common and weird styles
	elseif 'ES_weird' == s then
		sComma, sSep = "'", '.'
	elseif 'DE' == s or 'ES' == s or 'PT_BR' == s then
		sComma, sSep = ',', '.'
	elseif 'JA' == s or 'EN' == s then
		sComma, sSep = '.', ','
	elseif 'FR' == s or 'PT' == s or 'PL' == s then
		sComma, sSep = ',', ' '
	elseif 'SV' == s then
		sComma, sSep = ':', ' '
	end

	local sOut = ''
	local tParts tS.split(tostring(n), '.')

 -- TODO:

	return sOut

end -- pretty_num
--]]

-- split string s by separator sep and return a table with the parts
-- set third parameter to true to include empty parts
tS.split = function(s, sep, b)

	if 'string' ~= type(s)
		or 'string' ~= type(sep)
		or '' == sep then return nil end

	local t = {}
	local function insert(sPart)
		if not b and '' == sPart then return end
		table.insert(t, sPart)
	end -- insert

	local iL, iN = 0
	repeat

		iN = string.find(s, sep, iL, true)
		if not iN then
			insert(string.sub(s, iL, -1))
			break
		end

		insert(string.sub(s, iL, iN - 1))
		iL = iN + 1

	until false

	return t

end -- split


-- currently unsure which method to use so I'm providing both
mooncontroller.luacontroller_libraries['string'] = tS
mooncontroller.luacontroller_libraries['string_env'] = function(env)

	env.string.begins_with = tS.begins_with
	env.string.contains = tS.contains
	env.string.ellipsis = tS.ellipsis
	env.string.ends_with = tS.ends_with
	env.string.pretty_num = tS.pretty_num
	env.string.split = tS.split

	-- probably not a good idea
	return tS

end

