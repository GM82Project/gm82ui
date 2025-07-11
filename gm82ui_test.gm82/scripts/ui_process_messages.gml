///ui_process_messages(element)

instance_activate_object(global.__gm82ui_obj)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__gm82ui_obj) {
    show_error("in function ui_process_messages: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

__gm82ui_process_inner(argument0)

//handle death
with (global.__gm82ui_obj) if (dead) {
    __gm82ui_fire_handler("destroy",noone)
    ui_orphan(self)
    __gm82ui_destroy_inner(self)
}

instance_deactivate_object(global.__gm82ui_obj)

//clear all messages
var key;key=ds_map_find_first(global.__gm82ui_messages) repeat (ds_map_size(global.__gm82ui_messages)) {
    ds_list_destroy(ds_map_find_value(global.__gm82ui_messages,key))
key=ds_map_find_next(global.__gm82ui_messages,key)}
ds_map_clear(global.__gm82ui_messages)
