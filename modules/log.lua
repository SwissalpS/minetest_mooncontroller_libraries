-- a very basic logger to mem
-- in the past I had added timestamp/date_time_string but
-- found it to be of very little value and just filled up mem
-- if user wants it, he can make his own function that adds
-- that and whatever else to a table and pass that table to log()

-- wrapper so we don't need to write the same code twice, once for
-- 'log' and once for 'log_env' library
local function get_log(env)

	local mem = env.mem

	return function(m)

		if '¡clear_log!' == m then
			mem.log = {}
			return
		end

		if not mem.log then mem.log = {} end
		if (mem.log_max or 15) <= #mem.log then
			table.remove(mem.log, 1)
		end

		if nil == m then m = 'nil' end
		mem.log[#mem.log + 1] = m

	end -- log

end -- get_log


mooncontroller.luacontroller_libraries['log'] = function(env)

	return get_log(env)

end -- add log library


mooncontroller.luacontroller_libraries['log_env'] = function(env)

	env.log = get_log(env)

	return env.log

end -- add log library

