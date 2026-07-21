local formspec = "size[8,8]"
    .. "formspec_version[4]"
    .. "list[context;main;0,0;8,4;]"
    .. "list[current_player;main;0,4.25;8,4;]"
    .. "listring[]"
--only for the first time
local function showformspec(pos, playername)
    local strpos = pos.x .. "," .. pos.y .. "," .. pos.z
    local formspec = "size[8,8]"
        .. "formspec_version[4]"
        .. "list[nodemeta:" .. strpos .. ";main;0,0;8,4;]"
        .. "list[current_player;main;0,4.25;8,4;]"
        .. "listring[]"
    core.show_formspec(playername, "lootchest", formspec)
end
function deepcaves.register_lootchest(chestdef, loot)
    local weightlist = {}
    for index, item in ipairs(loot.loot) do
        local weight = item.weight or 1
        for i = 1, weight do
            table.insert(weightlist, index)
        end
    end

    local function get_loot(pos)
        local max_items = loot.data.max_items or 32
        local items = #loot.loot
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
            showformspec(pos, clicker:get_player_name())
        end
    end
    chestdef.on_rightclick = onrightclick
    chestdef.is_ground_content = false
    core.register_node(chestdef.name, chestdef)
end



