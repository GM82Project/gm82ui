///ui_compute_layout(ui,[x,y,[rotation,xscale,yscale]])

if (argument_count!=1 and argument_count!=3 and argument_count!=6) {show_error("bruh",0) exit}

dx=ui_preserve
dy=ui_preserve
rot=ui_preserve
xsc=ui_preserve
ysc=ui_preserve

if (argument_count>=3) {
    dx=argument[1]
    dy=argument[2]
}
if (argument_count==6) {
    rot=argument[3]
    xsc=argument[4]
    ysc=argument[5]
}

instance_activate_object(global.__ui_obj)
ui_compute_inner(argument[0],dx,dy,rot,xsc,ysc)
instance_deactivate_object(global.__ui_obj)
