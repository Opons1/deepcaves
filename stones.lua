deepcaves.stones = {}
local function register_stone(texture, name, description, level, tier, max_digs)
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

    
    for i = 1, variants do
        local fullname = "deepcaves:" .. name
        if i ~= 1 then
            fullname = fullname .. i
        end
        if replacer then replacer.blacklist[fullname] = true end
        core.register_node(fullname, {
            description = description,
            groups = {cracky = level},
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
                    local inv = digger:get_inventory()
                    inv:add_item("main", "default:cobble")
                end

                core.sound_play("default_cool_lava", {pos = pos, gain = 0.5})
            end,
            drop = "default:cobble",
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

                core.sound_play("default_cool_lava", {pos = pos, gain = 0.5})
            end
        })
    end
    table.insert(deepcaves.stones, {
        texture = texture,
        name = name,
        description = description,
        level = level,
        tier = tier,
    })
end

register_stone("deepcaves_densestone1.png", "dense_stone", "Dense Stone", 3, 2, 100)