///ui_append_child(element,child)

instance_activate_object(argument0)
instance_activate_object(argument1)

ds_list_add(argument0.children,argument1)
argument1.parent=argument0

instance_deactivate_object(argument0)
instance_deactivate_object(argument1)
