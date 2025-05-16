///ui_remove_child(element)

instance_activate_object(argument0)

if (argument0.parent==noone) exit

instance_activate_object(argument0.parent)

var p;p=ds_list_find_index(argument0.parent.children,argument1.id)

if (p==-1) {
    show_error("ui_remove_child failed",false)
} else {
    ds_list_delete(argument0.children,p)
}

instance_deactivate_object(argument0)
instance_deactivate_object(argument1)

__gm82ui_mark_stale(element)
