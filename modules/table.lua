local tT = {}

-- runs function f on every item in table t
-- e.g. apply({ 'a', 'b', 'c' },
--            function(s) return string.upper(s) .. '.' end)
-- returns { 'A.', 'B.', 'C.' }
tT.apply = function(t, f)

	if 'table' ~= type(t) or 'function' ~= type(f) then return nil end

	for k, v in pairs(t) do
		t[k] = f(v)
	end

	-- no need to return it, but gives user the flexibility
	return t

end -- apply


-- searches given table t for value m and returns
-- the key containing m or false
tT.contains = function(t, m)

	if 'table' ~= type(t) or nil == m then return nil end

	for k, v in pairs(t) do
		if v == m then return k end
	end

	return false

end -- contains


-- faster search for lists (tables with number indexes)
-- e.g. { 'a', 'b', 'c' }
-- will not work well if indexes are not continuous
-- returns the index containing m or false
tT.list_contains = function(t, m)

	if 'table' ~= type(t) or nil == m then return nil end

	local i = #t
	if 0 == i then return false end

	repeat
		if t[i] == m then return i end
		i = i - 1
	until 0 == i

	return false

end -- list_contains


-- return the keys of a table
tT.keys = mooncontroller_libs.table_keys


-- currently unsure which method to use so I'm providing both
mooncontroller.luacontroller_libraries['table'] = tT
mooncontroller.luacontroller_libraries['table_env'] = function(env)

	env.table.apply = tT.apply
	env.table.contains = tT.contains
	env.table.list_contains = tT.list_contains
	env.table.keys = mooncontroller_libs.table_keys

	return true

end

