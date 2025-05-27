///ui_orphan(element)

if (!global.__ui_in_handler) instance_activate_object(argument0)

if (!instance_exists(argument0)) exit

if (argument0.parent==noone) exit

if (!global.__ui_in_handler) instance_activate_object(argument0.parent)

ds_list_delete(argument0.parent.children,ds_list_find_index(argument0.parent.children,argument0.id))
argument0.parent=noone

if (!global.__ui_in_handler) {
    instance_deactivate_object(argument0.parent)
    instance_deactivate_object(argument0)
}

__gm82ui_mark_stale(element)
