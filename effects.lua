local time = 0
core.register_globalstep(function(dtime)
    time = time + dtime
    if time > 1 then
        time = time - 1
        for _, player in ipairs(core.get_connected_players()) do
            
        end
    end
end)

playereffects.register_effect_type(
    "deepcaves:poison",
    "Poison",
    "deepcaves_poison_extract.png",
    {"deepcaves_poison"},
    
    function(player)
        local hp = player:get_hp()
        if hp > 0 then
            player:set_hp(math.max(0, hp - 1), {
                custom_type = "deepcaves:poison",
            }) 
        end
    end,
    
    nil,
    false,
    true,
    1
)

core.register_on_joinplayer(function(player)
    playereffects.apply_effect_type("deepcaves:poison", 3, player)
end)

if announce_deaths then
    announce_deaths.register_custom_reason_death("deepcaves:poison", " was killed by poison.")
end