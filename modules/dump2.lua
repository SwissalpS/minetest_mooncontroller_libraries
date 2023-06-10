
mooncontroller.luacontroller_libraries['dump2'] = function(env)

	return dump2, function(m) env.print(dump2(m)) end

end -- add dump2 and print2 library


mooncontroller.luacontroller_libraries['dump2_env'] = function(env)

	env.dump2 = dump2
	env.print2 = function(m) env.print(env.dump2(m)) end

	return dump2, env.print2

end -- add dump2 and print2 to env

