///ui_set_format(element,resize,direction1,direction2)

if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__gm82ui_obj) {
    show_error("in function ui_set_format: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

argument0.resizable=argument1
argument0.direction1=argument2
argument0.direction2=argument3

if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)
