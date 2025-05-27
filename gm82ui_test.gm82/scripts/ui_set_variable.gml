///ui_set_variable(element,variable,value)

if (!global.__ui_in_handler) instance_activate_object(argument0)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__ui_obj) {
    show_error("in function ui_set_[variable]: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

variable_instance_set(argument0,argument1,argument2)
if (!global.__ui_in_handler) instance_deactivate_object(argument0)
