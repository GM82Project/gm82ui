///ui_set_alt(element,alt,help)

if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__gm82ui_obj) {
    show_error("in function ui_set_alt: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

argument0.alt=argument1
argument0.help=argument2

if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)
