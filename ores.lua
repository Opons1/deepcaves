deepcaves.ores = {}
local function register_ore(data)
    local ores = {}
    for _, stone in ipairs(deepcaves.stones) do
        local groups = table.copy(data.groups) or {}
        if not groups.cracky then
            groups.cracky = stone.level
        end
        core.register_node("deepcaves:" .. stone.name .. data.name, {
            decription = stone.description .. data.description,
            tiles = {stone.texture .. "^" .. data.tiles},
            groups = groups,
            drop = data.drop .. " " .. stone.tier
        })
        local orecid = core.get_content_id("deepcaves:" .. stone.name .. data.name)
        table.insert(ores, orecid)
    end
    deepcaves.ores[core.get_content_id(data.ore)] = ores 
end

register_ore({
    name = "dense_coal_ore",
    tiles = "deepcaves_densecoal1.png",
    description = " Dense Coal Ore",
    drop = "default:coal_lump",
    ore = "default:stone_with_coal"
})

register_ore({
    name = "dense_tin_ore",
    tiles = "deepcaves_densetin1.png",
    description = " Dense Tin Ore",
    drop = "default:tin_lump",
    ore = "default:stone_with_tin"
})

register_ore({
    name = "dense_copper_ore",
    tiles = "deepcaves_densecopper1.png",
    description = " Dense Copper Ore",
    drop = "default:copper_lump",
    ore = "default:stone_with_copper"
})

register_ore({
    name = "dense_iron_ore",
    tiles = "deepcaves_denseiron1.png",
    description = " Dense Iron Ore",
    drop = "default:iron_lump",
    ore = "default:stone_with_iron"
})

register_ore({
    name = "dense_gold_ore",
    tiles = "deepcaves_densegold1.png",
    description = " Dense Gold Ore",
    drop = "default:gold_lump",
    ore = "default:stone_with_gold",
    groups = {cracky = 1}
})

register_ore({
    name = "dense_diamond_ore",
    tiles = "deepcaves_densediamond1.png",
    description = " Dense Diamond Ore",
    drop = "default:diamond",
    ore = "default:stone_with_diamond",
    groups = {cracky = 1}
})

register_ore({
    name = "dense_mese_ore",
    tiles = "deepcaves_densemese1.png",
    description = " Dense Mese Ore",
    drop = "default:mese_crystal",
    ore = "default:stone_with_mese",
    groups = {cracky = 1}
})
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