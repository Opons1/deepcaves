local storage = core.get_mod_storage()

local function id_exists(id)
    return storage:get_int(id) == 1
end
local get_mapblock_id = deepcaves.get_mapblock_index
local maxy = -24755
--tracks if mapblocks are loading
local is_loading
--mark mapblocks generated after this 
core.register_lbm({
    label = "regenerate old caves",
    name = "deepcaves:regenerate_" .. 5,
    bulk_action = function(pos_list)
        for _, pos in ipairs(pos_list) do
            if pos.y < -24755 then
                local id = get_mapblock_id(pos)
                if not id_exists(id) then
                    core.delete_area(pos, pos)
                    storage:set_int(id, 1)
                    --core.chat_send_all("regerated mapblock " .. id)
                end
            end
        end
    end,
    nodenames = {"group:stone", "air", "group:cracky", "group:crumbly"}
})
--marks newly generated mapblocks as ok
core.register_on_generated(function(minp, maxp)
    if minp.y < maxy + 300 then 
        for x = minp.x, maxp.x, 16 do
            for y = minp.y, maxp.y, 16 do
                for z = minp.y, maxp.y, 16 do
                    local id = get_mapblock_id({x = x, y = y, z = z})
                    storage:set_int(id, 1)
                    --core.chat_send_all("generated" .. id)
                    is_loading = true
                end
            end
        end
    end
end)
local time = 0
--info
core.register_globalstep(function(dtime)
    time = time + dtime
    if time > 20 then
        time = 0
        if is_loading == true then
            core.chat_send_all(core.colorize("#757575", "Expect lag, deepcaves loading!"))
        end
        is_loading = false
    end
end)