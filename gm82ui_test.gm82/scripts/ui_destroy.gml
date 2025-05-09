///ui_destroy(element)
var i;

instance_activate_object(argument0)

with (argument0.parent) {
    ui_remove_child(id,argument0)
}

instance_activate_object(global.__ui_obj)

ui_destroy_inner(argument0)

instance_deactivate_object(global.__ui_obj)
