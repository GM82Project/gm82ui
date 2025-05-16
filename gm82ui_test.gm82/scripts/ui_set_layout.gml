///ui_set_layout(ui,x,y,[rotation,xscale,yscale])

if (argument_count!=3 and argument_count!=6) {show_error("bruh",0) exit}

rot=ui_preserve
xsc=ui_preserve
ysc=ui_preserve
dx=argument[1]
dy=argument[2]

if (argument_count==6) {
    rot=argument[3]
    xsc=argument[4]
    ysc=argument[5]
}

layout_engine(argument[0],dx,dy,rot,xsc,ysc)
