var p;

if (!global.__ui_in_handler) instance_activate_object(global.__ui_obj)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__ui_obj) {
    exit
}

p=argument0
while (p.parent) p=p.parent
p.layout_stale=true

if (!global.__ui_in_handler) instance_deactivate_object(global.__ui_obj)
