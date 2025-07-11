///ui_append_child(element,child)

var element;element=argument1
if (element<100000) element=ui_create(argument1)

if (!global.__gm82ui_in_handler) {
    instance_activate_object(argument0)
    instance_activate_object(element)
}

if (!instance_exists(argument0)) exit
if (!instance_exists(element)) exit

if (argument0.object_index!=global.__gm82ui_obj) {
    show_error("in function ui_append_child: element is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}
if (element.object_index!=global.__gm82ui_obj) {
    show_error("in function ui_append_child: child is "+object_get_name(element.object_index)+" instead of an ui element",0)
    exit
}

element.parent=argument0
ds_list_add(argument0.children,element)


var top;top=argument0
while (top.parent!=noone) {
    top=top.parent
    instance_activate_object(top)
}
element.taborder=top.tabcount
top.tabcount+=1
element.topowner=top


if (!global.__gm82ui_in_handler) {
    instance_deactivate_object(global.__gm82ui_obj)
}

__gm82ui_mark_stale(element)

return element
