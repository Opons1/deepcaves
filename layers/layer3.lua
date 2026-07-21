core.register_node("deepcaves:dense_sand", {
	description = "Dense Sand",
	groups = {crumbly = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_dense_sand.png"},
    light_source = 2,
    is_ground_content = false
})

--deco
core.register_decoration({
    deco_type = "simple",
    place_on = "deepcaves:dense_stone3_",
    fill_ratio = 10,
    flags = "all_floors, force_placement",
    decoration = "deepcaves:dense_sand",
    place_offset_y = -5,
    height = 5,
})