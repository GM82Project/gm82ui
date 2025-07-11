var l;

if (ds_map_exists(global.__ui_messages,argument0)) {
    l=ds_map_find_value(global.__ui_messages,argument0)
    if (handler==noone) {
        ds_list_destroy(l)
        ds_map_delete(global.__ui_messages,argument0)
        return 1
    } else {
        if (__gm82ui_fire_handler(argument0,l)) {
            ds_list_destroy(l)
            ds_map_delete(global.__ui_messages,argument0)
            return 1
        }
    }
}

return 0
