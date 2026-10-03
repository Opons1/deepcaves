
local item = deepcaves.itemlist

core.register_node("deepcaves:dense_sand", {
	description = "Dense Sand",
	groups = {crumbly = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_dense_sand.png"},
    paramtype = "light", light_source = 1,
    is_ground_content = false
})

core.register_node("deepcaves:dense_sand_purple", {
	description = "Purple Dense Sand",
	groups = {crumbly = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_dense_sand_purple.png"},
    paramtype = "light", light_source = 1,
    is_ground_content = false
})

core.register_node("deepcaves:dense_sandstone", {
	description = "Dense Sandstone",
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_dense_sand.png^(deepcaves_polished_overlay.png^[opacity:100)"},
    paramtype = "light", light_source = 2,
    is_ground_content = false
})

core.register_node("deepcaves:dense_sandstone_brick_1", {
	description = "Dense Sandstone Brick",
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_desert_brick_1.png"},
    is_ground_content = false
})

core.register_node("deepcaves:dense_sandstone_brick_2", {
	description = "Dense Sandstone Brick 2",
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_desert_brick_2.png"},
    is_ground_content = false
})

core.register_node("deepcaves:dense_sandstone_brick_3", {
	description = "Dense Sandstone Brick 3",
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_sand_defaults(),
    tiles = {"deepcaves_desert_brick_3.png"},
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
    paramtype = "light", light_source = 10,
    groups = {choppy = 3, tree = 1}
})
--craftitems

core.register_craftitem("deepcaves:poison_needle", {
    description = "Poisonous Cactus Needles",
    inventory_image = "deepcaves_purple_cactus_needles.png"
})

core.register_craftitem("deepcaves:poison_extract", {
    description = "Poison Extract",
    inventory_image = "deepcaves_poison_extract.png"
})

--tools
core.register_tool("deepcaves:poison_dagger", {
    description = "Poison Dagger",
    inventory_image = "deepcaves_poison_dagger.png",
    range = 2,
    tool_capabilities = {
        full_punch_interval = 0.3,
        max_drop_level = 0,
        groupcaps = {
            vines = {times = {[1] = 0.3, [2] = 0.2, [3] = 0.1}, uses = 20, maxlevel = 1},
        },
        damage_groups = {fleshy = 5},
    },
    on_use = function(itemstack, user, pointed_thing)
	    if pointed_thing.type == "object" then
		    local target = pointed_thing.ref
		    if target:is_player() then
                playereffects.apply_effect_type("deepcaves:poison", 6, pointed_thing)
		    end
	    end
	end,
})

--recipes

core.register_craft({
    output = "deepcaves:poison_needle 4",
    type = "cooking",
    cooktime = 24,
    recipe = "deepcaves:purple_cactus"
})

core.register_craft{
    output = "deepcaves:poison_extract",
    recipe = {
        {"deepcaves:poison_needle", "deepcaves:poison_needle", "deepcaves:poison_needle"},
        {"deepcaves:poison_needle", "deepcaves:poison_needle", "deepcaves:poison_needle"},
        {"", item.mortar_pestle, ""}
    },
    replacements = {
        {item.mortar_pestle, item.mortar_pestle}
    }
}

core.register_craft({
    output = "deepcaves:poison_dagger",
    recipe = {
        {"deepcaves:poison_extract"},
        {"default:diamond"},
        {"group:stick"},
    }
})
--deco

core.register_decoration({
    deco_type = "simple",
    place_on = deepcaves.stones[3].nodes,
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
    place_on = deepcaves.stones[3].nodes,
    fill_ratio = 10,
    flags = "all_floors, force_placement",
    decoration = "deepcaves:dense_sand",
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