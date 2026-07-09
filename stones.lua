deepcaves.stones = {}
local function register_stone(texture, name, description, level, tier, max_digs)
    
    core.register_node("deepcaves:" .. name, {
        title = title,
        groups = {cracky = level},
        tiles = {texture .. "^[crack:1:2"},
        node_dig_prediction = "deepcaves:" .. name,
        on_dig = function(pos, node, digger)
            local current_digs = node.param2

            if current_digs >= max_digs then
                core.node_dig(pos, node, digger)
                return
            end

            node.param2 = current_digs + 1
            core.swap_node(pos, node)

            local inventory = digger:get_inventory()
            if inventory then
                inventory:add_item("main", "default:cobble 1")
            end

            core.sound_play("default_cool_lava", {pos = pos, gain = 0.5})
        end,
    })
    table.insert(deepcaves.stones, {
        texture = texture,
        name = name,
        description = description,
        level = level,
        tier = tier,
    })
end

register_stone("deepcaves_densestone1.png", "dense_stone", "Dense Stone", 2, 2, 5)