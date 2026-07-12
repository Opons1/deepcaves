deepcaves.stones = {}
local function register_stone(texture, name, description, level, tier, max_digs, drop, not_stone)
    --total stone types
    local variants
    --calculate number needed to reigister
    if max_digs <= 6 then
        variants = max_digs
    else
        variants = 6
    end
    --where the used overlays are stored
    local overlays = {}
    --step between cracks, to calculate the ones used
    local crackstep = variants / 5
    for i = 0, variants do
        local crack = math.round(crackstep * i)
        if i > 0 then
            table.insert(overlays, "^[crack:1:" .. i)
        else
            table.insert(overlays, "")
        end
    end

    local nodes = {}
    --map variants to digs
    if max_digs <= 6 then
        for i = 1, variants - 1 do
            nodes[i] = "deepcaves:" .. name .. (i + 1)
        end
    else
        --calculate how the steps are divided
        local function findstep(i)
            return math.min(math.ceil(6 * i / max_digs), 6)
        end
        
        local prev_successful_index = 1
        for i = 1, max_digs do
            local step = findstep(i)
            
            if step ~= prev_successful_index then
                nodes[i] = "deepcaves:" .. name .. step
                prev_successful_index = step
            end
        end
    end

    --register the nodes
    for i = 1, variants do
        local fullname = "deepcaves:" .. name
        if i ~= 1 then
            fullname = fullname .. i
        end
        if replacer then replacer.blacklist[fullname] = true end
        
        local groups = {cracky = level}
        if i ~= 1 then
            groups.not_in_creative_inventory = 1
        end

        core.register_node(fullname, {
            description = description,
            groups = groups,
            tiles = {texture .. overlays[i]},
            node_dig_prediction = fullname,
            on_dig = function(pos, node, digger)
                local current_digs = node.param2

                if current_digs >= max_digs - 1 then
                    core.node_dig(pos, node, digger)
                    return
                end
                if nodes[current_digs] then node.name = nodes[current_digs] end
                local dug = core.node_dig(pos, node, digger)

                if dug then
                    node.param2 = current_digs + 1
                    core.swap_node(pos, node)
                end
            end,

            drop = "default:cobble" or drop,

            on_blast = function(pos)
                local node = core.get_node(pos)
                local current_digs = node.param2

                if current_digs >= max_digs - 1 then
                    core.node_dig(pos, node, digger)
                    return
                end

                if nodes[current_digs] then node.name = nodes[current_digs] end
                node.param2 = current_digs + 1
                core.swap_node(pos, node)
                return {"default:cobble"}
            end,
            --to make undiggable by technic quarry
            _mcl_hardness = -1,
        	sounds = default.node_sound_stone_defaults(),
        })
    end
    if not not_stone then
        table.insert(deepcaves.stones, {
            texture = texture,
            name = name,
            description = description,
            level = level,
            tier = tier,
        })
    end
end

local function get_random_color()
    local r = math.random(0, 255)
    local g = math.random(0, 255)
    local b = math.random(0, 255)

    return core.colorspec_to_colorstring({r = r, g = g, b = b})
end


local texture = "deepcaves_densestone1.png"
local textureoverlay = "^(deepcaves_densestone1.png^[opacity:100^[transformR90)"
for i = 1, 40 do
    texture = texture .. "^[colorize:#000000:30"
    local utext = texture .. textureoverlay
    local drops = math.floor(i/5) + 1
    local digs = i * 2
    register_stone(utext, "dense_stone" .. i .. "_", "Dense Stone " .. i, 3, drops, digs, "default:cobble")
    texture = texture .. "^[colorize:" .. get_random_color() .. ":40"

end

if core.get_modpath("technic") then
    register_stone("technic_granite.png^(technic_granite.png^[opacity:100^[transformR90^[colorize:#191a45:80)", "dense_granite", "Dense Granite", 1, 2, 10, "technic:granite", true)
    register_stone("technic_marble.png^(technic_marble.png^[opacity:100^[transformR90^[colorize:#191a45:80)", "dense_marble", "Dense Marble", 1, 2, 10, "technic:marble", true)

end