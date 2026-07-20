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
    light_source = 10,
    groups = {choppy = 3, tree = 1}
})


core.register_node("deepcaves:glow_wood", {
    description = "Glowstone Wood",
    tiles = {"deepcaves_glow_planks.png"},
    is_ground_content = false,
    light_source = 8,
    groups = {choppy = 3, wood = 1}
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

core.register_node("deepcaves:glow_sapling", {
	description = "Glow Tree Sapling",
	drawtype = "plantlike",
	tiles = {"deepcaves_glow_sapling.png"},
	inventory_image = "deepcaves_glow_sapling.png",
	wield_image = "deepcaves_glow_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = function(pos)
		default.grow_sapling(pos)
	end,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 3, attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		core.get_node_timer(pos):start(math.random(300, 700))
	end,
})

default.register_sapling_growth("deepcaves:glow_sapling", {
	can_grow = function(pos)
		pos.y = pos.y - 1
		local below = core.get_node(pos)
		pos.y = pos.y + 1
		if not below then return false end
		if not below.name then return false end
		if below.name ~= "deepcaves:stone_with_glow_grass" then return false end
		return true
	end,
	on_grow_failed = function(pos)
		core.get_node_timer(pos):start(100)
	end,
	grow = function(pos)
		local height = math.random(4, 10)
		local oldy = pos.y
		core.set_node(pos, {name = "deepcaves:glowtrunk"})
		for i = 2, height do
			pos.y = pos.y + 1
			if core.get_node(pos) and core.get_node(pos).name == "air" then
				core.set_node(pos, {name = "deepcaves:glowtrunk"})
			end
		end
		pos.y = pos.y + 1
		local col = math.random(1, 2)
		local schem
		if col == 1 then
			schem = mp .. "/schematics/deepcaves_glowtree1.mts"
		else
			schem = mp .. "/schematics/deepcaves_glowtree2.mts"
		end

		core.place_schematic(pos, schem, "random", {},  false, {
			place_center_x = true,
			place_center_z = true,
		})
		pos.y = oldy
	end
})
--crafts
core.register_craft({
	type = "shapeless",
	output = "deepcaves:glow_wood 4",
	recipe = {"deepcaves:glowtrunk"}
})

--lootchest
local loot = {
    data = {max_items = 32},
    loot = {
        {name = "default:cobble", max_count = 10, weight = 1},
        {name = "default:torch", max_count = 4, weight = 2},
        {name = "default:coal_lump", weight = 3},
        {name = "default:iron_lump", weight = 1},
        {name = "", weight = 6},

    }
}

local stext = deepcaves.stones[2].texture
deepcaves.register_lootchest(
    {
        name = "deepcaves:chest2",
        description = "Loot Chest",
        paramtype2 = "facedir",
        groups = {choppy = 2, oddly_breakable_by_hand = 2},
        sounds = default.node_sound_wood_defaults(),
        tiles = {
            stext .. "^(deepcaves_chest_top_overlay.png^[opacity:100)",
            stext .. "^(deepcaves_chest_top_overlay.png^[opacity:100)",
            stext .. "^(deepcaves_chest_side_overlay.png^[opacity:100)",
            stext .. "^(deepcaves_chest_side_overlay.png^[opacity:100)",
            stext .. "^(deepcaves_chest_side_overlay.png^[opacity:100)",
            stext .. "^(deepcaves_chest_front_overlay.png^[opacity:100)",

        },
        drop = ""
    },
    loot
)

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
	deco_type = "schematic",
    place_on = "deepcaves:stone_with_glow_grass",
	fill_ratio = 0.00004,
    flags = "all_floors, force_placement, place_center_x, place_center_z",
    schematic = mp .. "/schematics/deepcaves_dungeon1.mts",
	place_offset_y = -3,
	replacements = {
		["default:stone"] = "deepcaves:decorative_dense_stone2_",
		["default:stonebrick"] = "deepcaves:decorative_dense_stone2_bricks",
		["default:stone_block"] = "deepcaves:polished_decorative_dense_stone2_",
		["default:chest"] = "deepcaves:chest2",
	},
})

core.register_decoration({
    deco_type = "simple",
    place_on = "deepcaves:stone_with_glow_grass",
    fill_ratio = 0.4,
    flags = "all_floors, force_placement",
    decoration = {"deepcaves:glow_grass" , "deepcaves:glow_grass2",},
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
    flags = "all_floors, place_center_x, place_center_z",
    schematic = mp .. "/schematics/deepcaves_glowtree1.mts"
})
core.register_decoration({
    deco_type = "schematic",
    place_on = "deepcaves:glowtrunk",
    fill_ratio = 10,
    flags = "all_floors, place_center_x, place_center_z",
    schematic = mp .. "/schematics/deepcaves_glowtree2.mts"
})