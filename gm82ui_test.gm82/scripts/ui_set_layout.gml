///ui_set_layout(ui,x,y,[rotation,xscale,yscale])

if (argument_count!=3 and argument_count!=6) {show_error("in function ui_set_layout: wrong number of arguments",0) exit}

if (!instance_exists(argument[0])) exit

if (argument[0].object_index!=global.__ui_obj) {
    show_error("in function ui_set_layout: instance is "+object_get_name(argument[0].object_index)+" instead of an ui element",0)
    exit
}

dx=argument[1]
dy=argument[2]
rot=ui_default
xsc=ui_default
ysc=ui_default

if (argument_count==6) {
    rot=argument[3]
    xsc=argument[4]
    ysc=argument[5]
}

__gm82ui_layout_engine(argument[0],dx,dy,rot,xsc,ysc)
