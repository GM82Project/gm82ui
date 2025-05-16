///ui_set_constraints(element,minwidth,minheight,maxwidth,maxheight)

instance_activate_object(argument0)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__ui_obj) {
    show_error("in function ui_set_constraints: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

argument0.minwidth=argument1
argument0.minheight=argument2
argument0.maxwidth=argument3
argument0.maxheight=argument4

instance_deactivate_object(argument0)
