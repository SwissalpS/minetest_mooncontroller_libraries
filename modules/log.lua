mooncontroller.luacontroller_libraries['log'] = function(env, pos)

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

	end -- log function

end -- add log library

