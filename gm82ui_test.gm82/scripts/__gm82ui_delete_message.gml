if (ds_map_exists(global.__ui_messages,argument0)) {
    ds_list_destroy(ds_map_find_value(global.__ui_messages,argument0))
    ds_map_delete(global.__ui_messages,argument0)
    return 1
}
return 0
