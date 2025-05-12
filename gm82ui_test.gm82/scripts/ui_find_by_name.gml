var find;

find=noone

instance_activate_object(global.__ui_obj)
with (global.__ui_obj) {
    if (is_string(name)==is_string(argument0)) if (name==argument0) {find=id break}
}
instance_deactivate_object(global.__ui_obj)

instance_activate_object(find)
return find
