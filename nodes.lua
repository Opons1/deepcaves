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


core.register_node("deepcaves:glow_large_vine", {
	description = "Glow Vine Block",
	tiles = {"deepcaves_glow_large_vine.png"},
	waving = 1,
    light_source = 8,
	is_ground_content = false,
	groups = {snappy = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
})