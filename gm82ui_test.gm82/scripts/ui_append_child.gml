///ui_append_child(element,child)

instance_activate_object(argument0)

var element;element=argument1
if (element<100000) element=ui_create(argument1)

instance_activate_object(element)
element.parent=argument0
ds_list_add(argument0.children,element)

instance_deactivate_object(argument0)

return element
