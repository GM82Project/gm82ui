///ui_set_transform(ui,rotation,xscale,yscale)

if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__gm82ui_obj) {
    show_error("in function ui_set_layout: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

__gm82ui_layout_engine(argument0,ui_default,ui_default,argument1,argument2,argument3)

if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)
