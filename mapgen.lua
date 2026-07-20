local maxy = -24755

local noise_params1 = {
    offset = 2,
    scale = 1,
    spread = {x = 30, y = 30, z = 30},
    seed = 54321,
    octaves = 2,
    persist = 0.4,
    lacunarity = 4,
    flags = "defaults"
}

local noise_params2 = {
    offset = 2,
    scale = 1,
    spread = {x = 30, y = 30, z = 30},
    seed = 54321,
    octaves = 2,
    persist = 0.4,
    lacunarity = 4,
    flags = "defaults"
}

local function calculatemaplayer(y)
    local depth = maxy - y
    local level = math.floor(depth / 240) + 1
    level = math.max(1, math.abs(level))
    local key = maxy - ((level - 1) * 240) - 120
    return key, level
end
local map_surface = nil
local map_ceiling = nil

local buffer_surface = {}
local buffer_ceiling = {}
--stones
local c_stones = {}
local is_stone = {}

for i = 1, 26 do
    table.insert(c_stones, core.get_content_id("deepcaves:dense_stone" .. i .. "_"))
    is_stone[core.get_content_id("deepcaves:dense_stone" .. i .. "_")] = true
end

local c_gravel = core.get_content_id("default:gravel")
local c_silver_sand = core.get_content_id("default:silver_sand")
local c_mt_stone = core.get_content_id("default:stone")
local c_air = core.get_content_id("air")
local c_mossycobble = core.get_content_id("default:mossycobble")
local c_cobble = core.get_content_id("default:cobble")
local c_stair = core.get_content_id("stairs:stair_cobble")
--fluids to annihlate
local c_water = core.get_content_id("default:water_source")
local c_lava = core.get_content_id("default:lava_source")
--LAYER 2
local c_glowstone = core.get_content_id("deepcaves:glowstone")



local orepath = core.get_worldpath() .. "/deepcavesoredata.txt"

local file, err = io.open(orepath, "r")
if not file then
    error("[Deepcaves] Ore file missing: " .. tostring(err))
end

local content = file:read("*all")
file:close()

local ores = core.deserialize(content)

--store all the ground content now, imagine the pain of getting every node ever
local not_ground_content = {}
for name, def in pairs(core.registered_nodes) do
    if def.is_ground_content == false then
        local cid = core.get_content_id(name)
        not_ground_content[cid] = true
    end
end

not_ground_content[c_mossycobble] = false
not_ground_content[c_water] = false
not_ground_content[c_lava] = false
not_ground_content[c_cobble] = false
not_ground_content[c_stair] = false

local function tostone(lev)
    return c_stones[lev]
end

local actions = {
    [c_air] = function(lev) return tostone(lev) end,
    [c_mt_stone] = function(lev) return tostone(lev) end,
    [c_water] = function(lev) return tostone(lev) end,
    [c_lava] = function(lev) return tostone(lev) end,
    [c_mossycobble] = function(lev) return tostone(lev) end,
    [c_gravel] = function(lev) return tostone(lev) end,
    [c_silver_sand] = function(lev) return tostone(lev) end,
}

if core.registered_nodes["deepcaves:dense_granite"] then
    local c_granite = core.get_content_id("technic:granite")
    local c_dense_granite = core.get_content_id("deepcaves:dense_granite")
    actions[c_granite] = function(lev) return c_dense_granite end
end

if core.registered_nodes["deepcaves:dense_marble"] then
    local c_marble = core.get_content_id("technic:marble")
    local c_dense_marble = core.get_content_id("deepcaves:dense_marble")
    actions[c_marble] = function(lev) return c_dense_marble end
end

local function ifhasthenadd(name)
    if core.registered_nodes[name] then
        local c_name = core.get_content_id(name)
        actions[c_name] = function(lev) return tostone(lev) end
    end
end
local keygenscripts = {
    [1] = function(vi)
        return false
    end,
    --glow trees
    [2] = function(area, data, x, y, z, seed)
        if y > -25075 and y < -25065 then
            local vi = area:index(x, y, z)
            local rand = PcgRandom(core.hash_node_position({x = x, y = y, z = z}))
            if rand:next(1, 125) == 1 then
                data[vi] = c_glowstone
            end
        end
    end,
    [3] = function(area, data, x, y, z, seed)
    end,
}

core.register_on_generated(function(vm, minp, maxp, blockseed)
    if minp.y > maxy then return end
    local data = vm:get_data()
    local key, lev = calculatemaplayer(minp.y)
    print(lev)
    
    local emin, emax = vm:get_emerged_area()
    local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})

    local x0, y0, z0 = emin.x, minp.y, emin.z
    local x1, y1, z1 = emax.x, maxp.y, emax.z

    local side_x = x1 - x0 + 1
    local side_z = z1 - z0 + 1

    local map_size = {x = side_x, y = side_z}

    map_surface = map_surface or core.get_perlin_map(noise_params1, map_size)
    map_ceiling = map_ceiling or core.get_perlin_map(noise_params2, map_size)

    local noise_surface = map_surface:get_2d_map_flat({x = x0, y = z0, z = key}, buffer_surface)
    local noise_ceiling = map_ceiling:get_2d_map_flat({x = x0, y = z0, z = key}, buffer_ceiling)
    local light_data = vm:get_light_data() 
    local n_idx = 1
    for z = z0, z1 do
        for x = x0, x1 do
            local noise_val = noise_surface[n_idx]
            local noise_valc = noise_ceiling[n_idx]
            n_idx = n_idx + 1

            local surface_y_add = noise_val * noise_val * noise_val * noise_val
            local surface_y = key - 40 + surface_y_add + 10
            local cieling_y = key - 40 + noise_valc * noise_valc * noise_valc - surface_y_add*3 + 140
            
            for y = y0, y1 do
                local vi = area:index(x, y, z)
                if not (y <= surface_y or y >= cieling_y) and y < maxy then
                    if not not_ground_content[data[vi]] then
                        data[vi] = c_air
                    end
                else
                    if ores[data[vi]] then
                        data[vi] = ores[data[vi]][lev]
                    elseif actions[data[vi]] then
                        data[vi] = actions[data[vi]](lev) or actions[data[vi]]
                    end
                end
                light_data[vi] = 255
            end
        end
    end

    local pos = {}
    for z = minp.z, maxp.z do
        pos.z = z
        for x = minp.x, maxp.x do
            pos.x = x
            for y = minp.y, maxp.y do
                pos.y = y
                local seed = core.hash_node_position(pos)
                if keygenscripts[lev] then
                    keygenscripts[lev](area, data, x, y, z, seed)
                end
            end
        end
    end


    --vm:set_light_data(light_data)
    --now the fun part
    vm:set_data(data)
    core.generate_decorations(vm, minp, maxp)
end)