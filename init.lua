local mp = core.get_modpath(core.get_current_modname())
deepcaves = {}
deepcaves.modpath = mp
dofile(mp .. "/stones.lua")
dofile(mp .. "/ores.lua")

core.register_mapgen_script(mp .. "/mapgen.lua")






deepcaves.modpath = nil