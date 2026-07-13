core.register_node("deepcaves:glowstone", {
    description = "Floating Glowstone",
    tiles = {"deepcaves_glow.png"},
    is_ground_content = false,
    light_source = 14
})

core.register_node("deepcaves:glowstoneground", {
    description = "Glowstone",
    tiles = {"deepcaves_glow_ground.png"},
    is_ground_content = false,
    light_source = 8,
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

minetest.register_node("deepcaves:stone_with_glow_grass", {
	description = "Stone With Glow Grass",
	tiles = {"deepcaves_glow_grass.png", deepcaves.stones[2].texture,
		{name = deepcaves.stones[2].texture .. "^deepcaves_glow_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
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
})


core.register_node("deepcaves:glow_large_vine", {
	description = "Glow Vine Block",
	tiles = {"deepcaves_glow_large_vine.png"},
	waving = 1,
    light_source = 8,
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
})