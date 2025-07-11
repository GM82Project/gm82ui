if (ds_map_exists(global.__gm82ui_messages,argument0)) {
    ds_list_destroy(ds_map_find_value(global.__gm82ui_messages,argument0))
    ds_map_delete(global.__gm82ui_messages,argument0)
    return 1
}
return 0
