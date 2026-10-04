deepcaves.config = {
    --clear out the caves where these caves spawn every update
    wipe_previous_mapgen = core.settings:get_bool("deepcaves_wipe_previous_mapgen", false),
}
deepcaves.config.has_opw_terumet = core.global_exists("terumet") and terumet.version and terumet.version.opw and true