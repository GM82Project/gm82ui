///ui_get_variable(element,variable)

if (!global.__ui_in_handler) instance_activate_object(argument0)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__ui_obj) {
    show_error("in function ui_get_[variable]: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

var ret;ret=variable_instance_get(argument0,argument1)
if (!global.__ui_in_handler) instance_deactivate_object(argument0)

return ret
