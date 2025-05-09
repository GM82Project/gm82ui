///ui_update_inner(element)
var i;

with (argument0) {
    if (!enabled) exit

    if (parent==noone) {
        x=0
        y=0
    } else {
        x=parent.lx+padding
        y=parent.ly+padding
    }

    lxi=x+margin
    lyi=y+margin
    lx=lxi
    ly=lyi
    lh=0 //line height
    lp=0 //line pad
    lph=0 //last pad hor
    lpv=0 //last pad vert

    i=0 repeat (ds_list_size(children)) {
        ui_update_inner(ds_list_find_value(children,i))
    i+=1}

    if (overflow==ui_over_fitcontents) {
        width=lx+lph+margin
        height=ly+lh+lp+margin
    }

    if (parent!=noone) {
        parent.lh=max(parent.lh,height+max(padding,parent.lpv))
        parent.lp=max(parent.lp,padding)
        if (type==ui_t_break) {
            parent.lx=parent.lxi
            parent.ly+=parent.lh
            parent.lh=0
            parent.lpv=parent.lp
            parent.lp=0
        } else {
            parent.lx+=width+max(padding,parent.lp)
            parent.lph=padding
        }
    }

    focus=0
    if (global.__ui_event_focus) {
        if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
            global.__ui_event_focus=0
            focus=1
        }
    }

    if (script_exists(handler)) {
        if (global.__ui_event_mouse_left) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_left=0
                script_execute(handler,id,"left click")
            }
        }
        if (global.__ui_event_mouse_right) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_right=0
                script_execute(handler,id,"right click")
            }
        }
        if (global.__ui_event_mouse_scrollup) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_scrollup=0
                script_execute(handler,id,"scroll up")
            }
        }
        if (global.__ui_event_mouse_scrolldown) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_scrolldown=0
                script_execute(handler,id,"scroll down")
            }
        }
    }
}
