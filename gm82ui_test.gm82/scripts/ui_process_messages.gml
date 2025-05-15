///ui_process_messages(element)

instance_activate_object(global.__ui_obj)
ui_process_inner(argument0)
instance_deactivate_object(global.__ui_obj)

//clear all messages
var key;key=ds_map_find_first(global.__ui_messages) repeat (ds_map_size(global.__ui_messages)) {
    ds_list_destroy(ds_map_find_value(global.__ui_messages,key))
key=ds_map_find_next(global.__ui_messages,key)}
ds_map_clear(global.__ui_messages)
