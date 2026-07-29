core.register_node("deepcaves:dense_sand", {
	description = "Dense Sand",
	groups = {crumbly = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_dense_sand.png"},
    light_source = 2,
    is_ground_content = false
})

core.register_node("deepcaves:dense_sand_purple", {
	description = "Purple Dense Sand",
	groups = {crumbly = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_dense_sand_purple.png"},
    light_source = 2,
    is_ground_content = false
})

core.register_node("deepcaves:dense_sandstone", {
	description = "Dense Sandstone",
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_dense_sand.png^(deepcaves_polished_overlay.png^[opacity:100)"},
    light_source = 2,
    is_ground_content = false
})

core.register_node("deepcaves:purple_cactus", {
    description = "Purple Cactus",
    paramtype2 = "facedir",
    tiles = {
        "deepcaves_purple_cactus_top.png",
        "deepcaves_purple_cactus_top.png",
        "deepcaves_purple_cactus.png",
        "deepcaves_purple_cactus.png",
        "deepcaves_purple_cactus.png",
        "deepcaves_purple_cactus.png",
    },
    is_ground_content = false,
    light_source = 10,
    groups = {choppy = 3, tree = 1}
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

core.register_decoration({
    deco_type = "simple",
    place_on = "deepcaves:dense_sand",
    sidelen = 1,
    noise_params = {
        offset = 0,           
        scale = 100000,                 
        spread = {x=250, y=250},
        seed = 12345,
        octaves = 4,
        persistence = 0.5,
        lacunarity = 2.0,
    },
    flags = "all_floors, force_placement",
    decoration = "deepcaves:dense_sand_purple",
    place_offset_y = -5,
    height = 5,
})

core.register_decoration({
    deco_type = "simple",
    place_on = "deepcaves:dense_sand_purple",
    fill_ratio = 0.07,
	sidelen = 4,
    flags = "all_floors, force_placement",
    decoration = "deepcaves:purple_cactus",
    height = 4,
    height_max = 10,
    spawn_by = "air",
    num_spawn_by = 4
})