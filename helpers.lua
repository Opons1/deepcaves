--checks if a item exists
function deepcaves.item_exists(name)
    if core.registered_items[name] then
        return true
    else
        return false
    end
end


