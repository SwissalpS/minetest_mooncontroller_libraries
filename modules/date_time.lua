local tDT = {}
-- TODO: throw errors instead of returning nil?

tDT.date_string = function(iTS, sFormat)

	iTS = iTS or os.time()
	sFormat = sFormat or ''

	-- TODO

	return '', iTS, sFormat

end -- date_string


tDT.time_string = function(iTS, sFormat)

	iTS = iTS or os.time()
	sFormat = sFormat or ''

	-- TODO

	return '', iTS, sFormat

end -- time_string


-- currently unsure which method to use so I'm providing both
mooncontroller.luacontroller_libraries['date_time'] = tDT
mooncontroller.luacontroller_libraries['date_time_env'] = function(env)

	env.date.tostring = tDT.date_string
	env.time.tostring = tDT.time_string

	-- probably not a good idea
	return tDT

end

