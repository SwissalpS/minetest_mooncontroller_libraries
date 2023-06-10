mooncontroller.luacontroller_libraries['vector'] = vector
mooncontroller.luacontroller_libraries['vector_env'] = function(env)

	if env.vector then
		error('Field "vector" already exists in env!\nYou should not load ' ..
			'both "vector_basic_env" and "vector_env" at the same time.')
	end

	env.vector = vector

	return vector

end

