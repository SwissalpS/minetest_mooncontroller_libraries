-- NOTE: os.time may return UTC while os.date/os.datetable returns
-- adjusted time

local tDT = {}

-- %Y: year 2023
-- %y: year 23
-- %m: month 06
-- %d: day 09
tDT.date_string = function(sFormat, tD)

	tD = tD or os.date("*t", os.time())
	if 'table' ~= type(tD) then return '<invalid arg #2>' end

	sFormat = sFormat or '%Y%m%d'
	if 'string' ~= type(sFormat) then return '<invalid arg #1>' end

	local sY, sy, sm, sd
	sY = tostring(tD.year or 1970)
	sy = string.sub(sY, -2)
	sm = string.sub('0' .. (tD.month or 1), -2)
	sd = string.sub('0' .. (tD.day or 1), -2)

	local r = mooncontroller_libs.string_replace
	local sOut = r(sFormat, '%Y', sY)
	sOut = r(sOut, '%y', sy)
	sOut = r(sOut, '%m', sm)
	return r(sOut, '%d', sd)

end -- date_string


-- %H: hour 07 and 19
-- %I: hour 07 and 07
-- %M: minute 08
-- %S: second 01
tDT.time_string = function(sFormat, mT)

	mT = mT or os.time()
	if 'number' == type(mT) then
		return tDT.timestamp_to_time(sFormat, mT)
	end

	if 'table' ~= type(mT) then return '<invalid arg #2>' end

	sFormat = sFormat or '%H%M%S'
	if 'string' ~= type(sFormat) then return '<invalid arg #1>' end

	local iI = mT.hour or 12
	if 12 < iI then iI = iI - 12 end
	if 0 == iI then iI = 12 end

	local sH, sI, sM, sS
	sH = string.sub('0' .. (mT.hour or 0), -2)
	sI = string.sub('0' .. iI, -2)
	sM = string.sub('0' .. (mT.min or 0), -2)
	sS = string.sub('0' .. (mT.sec or 0), -2)

	local r = mooncontroller_libs.string_replace
	local sOut = r(sFormat, '%H', sH)
	sOut = r(sOut, '%I', sI)
	sOut = r(sOut, '%M', sM)
	return r(sOut, '%S', sS)

end -- time_string


-- %H, %I, %M, %S
tDT.timestamp_to_time = function(sFormat, iTS)

	iTS = iTS or os.time()
	if 'number' ~= type(iTS) then return '<invalid arg #2>' end

	sFormat = sFormat or '%H%M%S'
	if 'string' ~= type(sFormat) then return '<invalid arg #1>' end

	local iM = math.floor(iTS / 60)
	local iS = iTS % 60
	local iH = math.floor(iM / 60) % 24
	iM = iM % 60
	local iI = iH <= 12 and iH or iH - 12
	if 0 == iH then iH = 12 end

	local sH, sI, sM, sS
	sH = string.sub('0' .. iH, -2)
	sI = string.sub('0' .. iI, -2)
	sM = string.sub('0' .. iM, -2)
	sS = string.sub('0' .. iS, -2)

	local r = mooncontroller_libs.string_replace
	local sOut = r(sFormat, '%H', sH)
	sOut = r(sOut, '%I', sI)
	sOut = r(sOut, '%M', sM)
	return r(sOut, '%S', sS)

end -- timestamp_to_time


-- currently unsure which method to use so I'm providing both
mooncontroller.luacontroller_libraries['date_time'] = tDT
mooncontroller.luacontroller_libraries['date_time_env'] = function(env)

	env.date = env.date or {}
	env.time = env.time or {}
	env.date.tostring = tDT.date_string
	env.time.tostring = tDT.time_string
	env.time.timestamp_to_time = tDT.timestamp_to_time --<---TODO: this needs a better name

	-- probably not a good idea
	return tDT

end

