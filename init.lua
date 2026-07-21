local mp = core.get_modpath(core.get_current_modname())
deepcaves = {}
deepcaves.modpath = mp
dofile(mp .. "/stones.lua")
dofile(mp .. "/ores.lua")
dofile(mp .. "/lootchests.lua")

dofile(mp .. "/layers/layer2.lua")
dofile(mp .. "/layers/layer3.lua")

--techage shouldnt dig the stone either
if techage and techage.dig_like_player then
    local old = techage.dig_like_player
    function techage.dig_like_player(pos, fake_player, add_to_inv)
        if core.registered_nodes[core.get_node(pos).name]._mcl_hardness == -1 then
            return techage.dig_states.NOT_DIGGABLE
        else
            return old(pos, fake_player, add_to_inv)
        end
    end
end

core.register_mapgen_script(mp .. "/mapgen.lua")

deepcaves = nil

--notes
--underworlds ends at -24755