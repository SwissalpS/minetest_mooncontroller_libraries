mooncontroller.luacontroller_libraries['vector_core'] = vector
mooncontroller.luacontroller_libraries['vector_core_env'] = function(env)

	if env.vector then
		error('Field "vector" already exists in env!\nYou should not load ' ..
			'both "vector_core_env" and "vector_env" at the same time.')
	end

	env.vector = vector

	return vector

end

