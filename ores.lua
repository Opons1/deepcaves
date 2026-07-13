deepcaves.ores = {}
local function register_ore(data)
    local ores = {}
    for _, stone in ipairs(deepcaves.stones) do
        local groups = table.copy(data.groups) or {}
        if not groups.cracky then
            groups.cracky = stone.level
        end
        core.register_node("deepcaves:" .. stone.name .. data.name, {
            description = stone.description .. data.description,
            tiles = {stone.texture .. "^" .. data.tiles},
            groups = groups,
            drop = data.drop .. " " .. stone.tier,
            light_source = data.light_source or 0
        })
        local orecid = core.get_content_id("deepcaves:" .. stone.name .. data.name)
        table.insert(ores, orecid)
    end
    deepcaves.ores[core.get_content_id(data.ore)] = ores 
end
local function gdtxt(texture)
    return "([combine:16x16:0,0=" .. texture .. "^[combine:16x16:1,-1=" .. texture .. ")"
end

register_ore({
    name = "dense_coal_ore",
    tiles = gdtxt("default_mineral_coal.png"),
    description = " Dense Coal Ore",
    drop = "default:coal_lump",
    ore = "default:stone_with_coal"
})

register_ore({
    name = "dense_tin_ore",
    tiles = gdtxt("default_mineral_tin.png"),
    description = " Dense Tin Ore",
    drop = "default:tin_lump",
    ore = "default:stone_with_tin"
})

register_ore({
    name = "dense_copper_ore",
    tiles = gdtxt("default_mineral_copper.png"),
    description = " Dense Copper Ore",
    drop = "default:copper_lump",
    ore = "default:stone_with_copper"
})

register_ore({
    name = "dense_iron_ore",
    tiles = gdtxt("default_mineral_iron.png"),
    description = " Dense Iron Ore",
    drop = "default:iron_lump",
    ore = "default:stone_with_iron"
})

register_ore({
    name = "dense_gold_ore",
    tiles = gdtxt("default_mineral_gold.png"),
    description = " Dense Gold Ore",
    drop = "default:gold_lump",
    ore = "default:stone_with_gold",
    groups = {cracky = 1}
})

register_ore({
    name = "dense_diamond_ore",
    tiles = gdtxt("default_mineral_diamond.png"),
    description = " Dense Diamond Ore",
    drop = "default:diamond",
    ore = "default:stone_with_diamond",
    groups = {cracky = 1, level = 3}
})

register_ore({
    name = "dense_mese_ore",
    tiles = gdtxt("default_mineral_mese.png"),
    description = " Dense Mese Ore",
    drop = "default:mese_crystal",
    ore = "default:stone_with_mese",
    groups = {cracky = 1, level = 2}
})
--moreores ore
if core.get_modpath("moreores") then
    register_ore({
        name = "dense_silver_ore",
        tiles = gdtxt("moreores_mineral_silver.png"),
        description = " Dense Mithril Ore",
        drop = "moreores:silver_lump",
        ore = "moreores:mineral_silver",
        groups = {cracky = 1, level = 2}
    })

    register_ore({
        name = "dense_mithril_ore",
        tiles = gdtxt("moreores_mineral_mithril.png"),
        description = " Dense Mithril Ore",
        drop = "moreores:mithril_lump",
        ore = "moreores:mineral_mithril",
        groups = {cracky = 1, level = 3}
    })
end
--technic ore
if core.get_modpath("technic") then
    register_ore({
        name = "dense_chromium_ore",
        tiles = gdtxt("technic_mineral_chromium.png"),
        description = " Dense Chromium Ore",
        drop = "technic:chromium_lump",
        ore = "technic:mineral_chromium",
        groups = {cracky = 1, level = 2}
    })

    register_ore({
        name = "dense_lead_ore",
        tiles = gdtxt("technic_mineral_lead.png"),
        description = " Dense Lead Ore",
        drop = "technic:lead_lump",
        ore = "technic:mineral_lead",
        groups = {cracky = 1, level = 2}
    })

    register_ore({
        name = "dense_zinc_ore",
        tiles = gdtxt("technic_mineral_zinc.png"),
        description = " Dense Zinc Ore",
        drop = "technic:zinc_lump",
        ore = "technic:mineral_zinc",
        groups = {cracky = 1, level = 2}
    })
end

if core.get_modpath("blox") then

    register_ore({
        name = "dense_glow_ore",
        tiles = gdtxt("blox_glowore.png"),
        description = " Dense Glow Ore",
        drop = "blox:glowdust",
        ore = "blox:glowore",
        groups = {cracky = 1, level = 2},
        light_source = 8,
    })
end

if core.get_modpath("terumet") then
    register_ore({
        name = "dense_terumetal_ore",
        tiles = gdtxt("terumet_ore_dense_raw.png"),
        description = " Dense Terumetal Ore",
        drop = "terumet:lump_raw",
        ore = "terumet:ore_raw",
        groups = {cracky = 1, level = 2},
    })

    register_ore({
        name = "dense_terumetal_ore2",
        tiles = gdtxt("terumet_ore_dense_raw.png"),
        description = " Dense Terumetal Ore",
        drop = "terumet:lump_raw",
        ore = "terumet:ore_dense_raw",
        groups = {cracky = 1, level = 2},
    })
end

if core.get_modpath("gs_amethyst") then
    register_ore({
        name = "dense_amethyst",
        tiles = gdtxt("gs_amethyst_ore.png"),
        description = " Dense Amethyst Ore",
        drop = "gs_amethyst:amethyst_ingot",
        ore = "gs_amethyst:amethyst_ore",
        groups = {cracky = 1, level = 3},
    })
end

if core.get_modpath("gs_emerald") then
    register_ore({
        name = "dense_emerald",
        tiles = gdtxt("gs_emerald_ore.png"),
        description = " Dense Emerald Ore",
        drop = "gs_emerald:emerald",
        ore = "gs_emerald:emerald_ore",
        groups = {cracky = 1, level = 3},
    })
end


if core.get_modpath("gs_ruby") then
    register_ore({
        name = "dense_ruby",
        tiles = gdtxt("gs_ruby_ore.png"),
        description = " Dense Ruby Ore",
        drop = "gs_ruby:ruby",
        ore = "gs_ruby:ruby_ore",
        groups = {cracky = 1, level = 3},
    })
end

if core.get_modpath("gs_sapphire") then
    register_ore({
        name = "dense_sapphire",
        tiles = gdtxt("gs_sapphire_ore.png"),
        description = " Dense Sapphire Ore",
        drop = "gs_sapphire:sapphire",
        ore = "gs_sapphire:sapphire_ore",
        groups = {cracky = 1, level = 3},
    })
end

if core.get_modpath("lapis") then
    register_ore({
        name = "dense_lapis",
        tiles = gdtxt("lapis_mineral_lapislazuli.png"),
        description = " Dense Lapis Lazuli Ore",
        drop = "lapis:lapis",
        ore = "lapis:stone_with_lapis",
        groups = {cracky = 1, level = 2},
    })
end

if core.get_modpath("quartz") then
    register_ore({
        name = "dense_quartz",
        tiles = gdtxt("quartz_ore.png"),
        description = " Dense Quartz Ore",
        drop = "quartz:quartz_crystal",
        ore = "quartz:quartz_ore",
        groups = {cracky = 1, level = 2},
    })
end

local function register_ore_for_stone(data)
    local stone = deepcaves.stones[data.stone]
    local texture = stone.texture
    core.register_node(data.name, {
        description = data.description,
        groups = data.groups,
        tiles = {texture},
        light_source = data.light_source or 0,
        drop = data.drop,
    })
end


--writing the data to be read later
local storage_path = core.get_worldpath() .. "/deepcavesoredata.txt"
local file, err = io.open(storage_path, "w") 
if not file then
    error("Failed to write ore cache: " .. tostring(err))
    return false
end
local orestring = core.serialize(deepcaves.ores)
file:write(orestring)
file:close()