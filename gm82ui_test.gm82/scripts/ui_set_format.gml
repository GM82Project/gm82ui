///ui_set_format(element,resize,overflow_h,overflow_v,direction1,direction2)

if (!global.__ui_in_handler) instance_activate_object(argument0)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__ui_obj) {
    show_error("in function ui_set_format: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

argument0.resizable=argument1
argument0.overflow_h=argument2
argument0.overflow_v=argument3
argument0.direction1=argument4
argument0.direction2=argument5

if (!global.__ui_in_handler) instance_deactivate_object(argument0)
