///ui_set_size(element,width,height,[margin,padding])

if (argument_count<3) {
    show_error("in function ui_set_size: wrong number of arguments",0)
    exit
}

instance_activate_object(argument[0])

if (!instance_exists(argument0)) exit

if (argument[0].object_index!=global.__ui_obj) {
    show_error("in function ui_set_size: instance is "+object_get_name(argument[0].object_index)+" instead of an ui element",0)
    exit
}

if (argument[1]!=ui_default) argument[0].setwidth=argument[1]
if (argument[2]!=ui_default) argument[0].setheight=argument[2]
if (argument_count==5) {
    if (argument[3]!=ui_default) argument[0].margin=argument[3]
    if (argument[4]!=ui_default) argument[0].padding=argument[4]
}

instance_deactivate_object(argument[0])
