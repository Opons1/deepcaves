local mp = core.get_modpath(core.get_current_modname())
--nodes
core.register_node("deepcaves:stone_with_glow_grass", {
	description = "Stone With Glow Grass",
	tiles = {
		"deepcaves_glow_grass.png", 
		deepcaves.stones[2].texture,
		{
			name = deepcaves.stones[2].texture .. "^deepcaves_glow_grass_side.png", 
			tileable_vertical = false
		}
	},
	groups = {cracky = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
    light_source = 6,
    is_ground_content = false
})

core.register_node("deepcaves:glow_grass", {
	description = "Glow Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"deepcaves_glow_grasses.png"},
	inventory_image = "deepcaves_glow_grasses.png",
	wield_image = "deepcaves_glow_grasses.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
		grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},
    is_ground_content = false,
})

core.register_node("deepcaves:glow_grass2", {
	description = "Glow Grass 2",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"deepcaves_glow_grasses_2.png"},
	inventory_image = "deepcaves_glow_grasses_2.png",
	wield_image = "deepcaves_glow_grasses_2.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
		grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},
    light_source = 8,
    is_ground_content = false,

})

core.register_node("deepcaves:glowtrunk", {
    description = "Glowstone Trunk",
    tiles = {
        "deepcaves_glow_trunk_top.png",
        "deepcaves_glow_trunk_top.png",
        "deepcaves_glow_trunk.png",
        "deepcaves_glow_trunk.png",
        "deepcaves_glow_trunk.png",
        "deepcaves_glow_trunk.png",
    },
    is_ground_content = false,
    light_source = 8,
    groups = {choppy = 3}
})

core.register_node("deepcaves:glowleaves", {
	description = "Glow Leaves",
	drawtype = "allfaces",
	tiles = {"deepcaves_glow_leaves.png"},
	waving = 1,
    light_source = 8,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("deepcaves:glowleaves2", {
	description = "Glow Leaves",
	drawtype = "allfaces",
	tiles = {"deepcaves_glow_leaves_2.png"},
	waving = 1,
    light_source = 8,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
})

core.register_node("deepcaves:glowstone", {
    description = "Floating Glowstone",
    tiles = {"deepcaves_glow.png"},
    is_ground_content = false,
    light_source = 14
})
--ores




--deco
core.register_decoration({
    deco_type = "simple",
    place_on = "deepcaves:dense_stone2_",
    fill_ratio = 10,
    flags = "all_floors, force_placement",
    decoration = "deepcaves:stone_with_glow_grass",
    place_offset_y = -1,
    is_ground_content = false,
})

core.register_decoration({
    deco_type = "simple",
    place_on = "deepcaves:stone_with_glow_grass",
    fill_ratio = 0.4,
    flags = "all_floors, force_placement",
    decoration = {"deepcaves:glow_grass" , "deepcaves:glow_grass2",}
})

core.register_decoration({
    deco_type = "simple",
    place_on = "deepcaves:stone_with_glow_grass",
    fill_ratio = 0.07,
    flags = "all_floors, force_placement",
    decoration = "deepcaves:glowtrunk",
    height = 4,
    height_max = 10,
    spawn_by = "deepcaves:stone_with_glow_grass",
    num_spawn_by = 4
})

core.register_decoration({
    deco_type = "schematic",
    place_on = "deepcaves:glowtrunk",
    sidelen = 4,
    fill_ratio = 1,
    flags = "all_floors, force_placement, place_center_x, place_center_z",
    schematic = mp .. "/schematics/deepcaves_glowtree1.mts"
})
core.register_decoration({
    deco_type = "schematic",
    place_on = "deepcaves:glowtrunk",
    fill_ratio = 10,
    flags = "all_floors, force_placement, place_center_x, place_center_z",
    schematic = mp .. "/schematics/deepcaves_glowtree2.mts"
})