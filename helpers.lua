--checks if a item exists
function deepcaves.item_exists(name)
    if core.registered_items[name] then
        return true
    else
        return false
    end
end
--gives each mapblock its own id
function deepcaves.get_mapblock_index(pos)
    local xindex = 2048 + math.floor(pos.x / 16)
    local yindex = 2048 + math.floor(pos.y / 16)
    local zindex = 2048 + math.floor(pos.z / 16)
    return xindex + yindex * 4096 + zindex * 16777216
end

