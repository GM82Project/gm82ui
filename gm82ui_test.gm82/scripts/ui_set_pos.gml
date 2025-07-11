///ui_set_pos(element,x,y)

if (!global.__gm82ui_in_handler) instance_activate_object(global.__gm82ui_obj)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__gm82ui_obj) {
    show_error("in function ui_set_pos: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

__gm82ui_move(argument0,argument1-argument0.x,argument2-argument0.y)

if (!global.__gm82ui_in_handler) instance_deactivate_object(global.__gm82ui_obj)
