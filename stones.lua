deepcaves.stones = {}
local function register_stone(texture, name, description, level, tier, max_digs)
    local variants
    if max_digs <= 6 then
           variants = max_digs
    else
        variants = 6
    end

    local overlays = {}
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

    local nodes = {}

    if variants <= 6 then
        for i = 1, variants - 1 do
            nodes[i] = "deepcaves:" .. name .. (i + 1)
        end
    else
        local function findstep(i)
            return math.max(math.ceil(6 * i / max_digs), 6)
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

        local crack_overlay = overlays[i]
        core.register_node(fullname, {
            title = title,
            groups = {cracky = level},
            tiles = {texture .. overlays[i]},
            node_dig_prediction = fullname,
            on_dig = function(pos, node, digger)
                local current_digs = node.param2

                if current_digs >= max_digs - 1 then
                    core.node_dig(pos, node, digger)
                    return
                end
                if nodes[i] then node.name = nodes[i] end
                node.param2 = current_digs + 1

                core.swap_node(pos, node)

                local inventory = digger:get_inventory()
                if inventory then
                    inventory:add_item("main", "default:cobble 1")
                end

             core.sound_play("default_cool_lava", {pos = pos, gain = 0.5})
            end,
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

register_stone("deepcaves_densestone1.png", "dense_stone", "Dense Stone", 2, 2, 5)