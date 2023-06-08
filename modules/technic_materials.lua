local mcls = mooncontroller_libs
mcls.tTM = {}
mcls.tTM.alloy_inputs = {}
mcls.tTM.centrifuge_inputs = {}
mcls.tTM.compressor_inputs = {}
mcls.tTM.extractor_inputs = {}
mcls.tTM.freezer_inputs = {}
mcls.tTM.furnace_inputs = {}
mcls.tTM.grinder_inputs = {}
-- in case a mooncontroller calls the lib early, we don't want to
-- cause 'indexing nil object' errors.
mooncontroller.luacontroller_libraries['technic_materials'] = mcls.tTM

local function get_cooking_inputs()

	-- getting cooking recipes is a bit of work:
	local l, i = {}, 0
	-- first loop through all craftitems
	for s, _ in pairs(minetest.registered_craftitems) do
		-- with each check for recipes and loop those
		for _, t in ipairs(minetest.get_all_craft_recipes(s) or {}) do
			-- to find if type/method is cooking
			if 'cooking' == t.type then
				-- then we can add the input to our list
				i = i + 1
				l[i] = t.items[1]
			end
		end
	end
	-- sort the list
	table.sort(l)

	return l

end -- get_cooking_inputs


local function scan()
-- TODO: check for existance of recipes-field(s)

	mcls.tTM.alloy_inputs = mcls.table_keys(technic.recipes.alloy.recipes)
	mcls.tTM.centrifuge_inputs = mcls.table_keys(technic.recipes.separating.recipes)
	mcls.tTM.compressor_inputs = mcls.table_keys(technic.recipes.compressing.recipes)
	mcls.tTM.extractor_inputs = mcls.table_keys(technic.recipes.extracting.recipes)
	mcls.tTM.freezer_inputs = mcls.table_keys(technic.recipes.freezing.recipes)
	mcls.tTM.furnace_inputs = get_cooking_inputs()
	mcls.tTM.grinder_inputs = mcls.table_keys(technic.recipes.grinding.recipes)

	-- register a copy of new cache
	mooncontroller.luacontroller_libraries['technic_materials'] = mcls.tTM

end -- scan
minetest.register_on_mods_loaded(function()
	minetest.after(1, scan)
end)

