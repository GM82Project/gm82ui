///ui_remove_child(element,child)

instance_activate_object(argument0)
instance_activate_object(argument1)

var p;p=ds_list_find_index(argument0.children,argument1)

if (p==-1) {
    show_error("ui_remove_child failed",false)
} else {
    ds_list_delete(argument0.children,p)
}

instance_deactivate_object(argument0)
instance_deactivate_object(argument1)
