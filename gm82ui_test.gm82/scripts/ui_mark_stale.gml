///ui_mark_stale(element)
var p;

instance_activate_object(global.__ui_obj)

p=argument0
while (p.parent) p=p.parent
p.layout_stale=true

instance_deactivate_object(global.__ui_obj)
