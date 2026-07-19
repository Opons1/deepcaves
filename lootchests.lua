local formspec = "size[8,8]"
    .. "formspec_version[4]"
    .. "list[context;main;0,0;8,4;]"
    .. "list[current_player;main;0,4.25;8,4;]"
    .. "listring[]"
    
function deepcaves.register_lootchest(chestdef, loot)
    local function get_loot(pos)
        local max_items = loot.data.max_items or 32
        local items = #loot.loot
        local weightlist = {}
        for index, item in ipairs(loot.loot) do
            local weight = item.weight
            for i = 1, weight do
                table.insert(weightlist, index)
            end
        end
        local items = {}
        local count = 0
        local rand = PcgRandom(core.hash_node_position(pos))
        while count < loot.data.max_items do
            local itemindex = weightlist[rand:next(1, #weightlist)]
            local itemcount = rand:next(1, loot.loot[itemindex].max_count or 1)
            local item = loot.loot[itemindex].name .. " " .. itemcount
            table.insert(items, item)
            count = count + 1
        end
        return items
    end
    local function onrightclick(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        if meta:get_string("formspec") == "" then
            inv:set_size("main", 32)
            meta:set_string("formspec", formspec)
            inv:set_list("main", get_loot(pos))
        end
    end
    chestdef.on_rightclick = onrightclick

    core.register_node(chestdef.name, chestdef)
end


local loot = {
    data = {max_items = 32},
    loot = {
        {name = "default:cobble", max_count = 10, weight = 1},
        {name = "default:torch", max_count = 4, weight = 2},
        {name = "default:coal_lump", weight = 3},
        {name = "default:iron_lump", weight = 1},
    }
}

deepcaves.register_lootchest(
    {
        name = "deepcaves:chest",
        description = "Loot Chest",
        paramtype2 = "facedir",
        groups = {choppy = 2, oddly_breakable_by_hand = 2},
        sounds = default.node_sound_wood_defaults(),
    },
    loot
)
