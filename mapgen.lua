local miny = -3331
local noise_params = {
    offset = 2,
    scale = 1,
    spread = {x = 30, y = 30, z = 30},
    seed = 54321,
    octaves = 2,
    persist = 0.4,
    lacunarity = 4,
    flags = "defaults"
}

local map_surface = nil
local map_ceiling = nil

local buffer_surface = {}
local buffer_ceiling = {}

local c_gravel = core.get_content_id("default:gravel")
local c_silver_sand = core.get_content_id("default:silver_sand")
local c_stone = core.get_content_id("deepcaves:dense_stone")
local c_mt_stone = core.get_content_id("default:stone")
local c_air = core.get_content_id("air")
local c_mossycobble = core.get_content_id("default:mossycobble")

--fluids to annihlate
local c_water = core.get_content_id("default:water_source")
local c_lava = core.get_content_id("default:lava_source")

local orepath = core.get_worldpath() .. "/deepcavesoredata.txt"

local file, err = io.open(orepath, "r")
if not file then
    error("[Deepcaves] Ore file missing: " .. tostring(err))
end

local content = file:read("*all")
file:close()

local ores = core.deserialize(content)



local actions = {
    [c_air] = c_stone,
    [c_mt_stone] = c_stone,
    [c_water] = c_stone,
    [c_lava] = c_stone,
    [c_mossycobble] = c_stone,
    [c_gravel] = c_stone,
    [c_silver_sand] = c_stone,

}

core.register_on_generated(function(vm, minp, maxp, blockseed)
    if maxp.y < miny then return end
    local light_data = vm:get_light_data() 
    local data = vm:get_data()
    
    local emin, emax = vm:get_emerged_area()
    local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})

    local x0, y0, z0 = emin.x, emin.y, emin.z
    local x1, y1, z1 = emax.x, emax.y, emax.z

    local side_x = x1 - x0 + 1
    local side_z = z1 - z0 + 1

    local map_size = {x = side_x, y = side_z}

    map_surface = map_surface or core.get_perlin_map(noise_params, map_size)
    map_ceiling = map_ceiling or core.get_perlin_map(noise_params, map_size)

    local noise_surface = map_surface:get_2d_map_flat({x = x0, y = z0}, buffer_surface)
    local noise_ceiling = map_ceiling:get_2d_map_flat({x = x0 + 100, y = z0 + 100}, buffer_ceiling)

    local n_idx = 1
    for z = z0, z1 do
        for x = x0, x1 do
            local noise_val = noise_surface[n_idx]
            local noise_valc = noise_ceiling[n_idx]
            n_idx = n_idx + 1

            local surface_y_add = noise_val * noise_val * noise_val * noise_val
            local surface_y = miny + surface_y_add + 10
            local cieling_y = miny + noise_valc * noise_valc * noise_valc - surface_y_add*3 + 140
            
            for y = y0, y1 do
                local vi = area:index(x, y, z)
                if not (y <= surface_y or y >= cieling_y) then
                    data[vi] = c_air
                    light_data[vi] = 255 
                else
                    if ores[data[vi]] then
                        data[vi] = ores[data[vi]][1]
                    elseif actions[data[vi]] then
                        data[vi] = actions[data[vi]]
                    end
                end
            end
        end
    end
    vm:set_light_data(light_data)
    vm:set_data(data)
end)
