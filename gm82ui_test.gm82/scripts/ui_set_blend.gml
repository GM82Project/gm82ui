///ui_set_blend(element,color,alpha)

instance_activate_object(argument0)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__ui_obj) {
    show_error("in function ui_set_blend: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

argument0.image_blend=argument1
argument0.image_alpha=argument2

instance_deactivate_object(argument0)
