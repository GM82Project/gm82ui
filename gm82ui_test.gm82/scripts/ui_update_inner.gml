///ui_update_inner(element)
var i;

if (!instance_exists(argument0)) return false

with (argument0) {
    if (!enabled) exit


    //pre-update handler
    if (script_exists(handler)) script_execute(handler,id,"step")


    //reset to defaults
    if (parent!=noone) {
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

    if (overflow==ui_over_fitcontents) {
        width=0
        height=0
    }


    //window type; probably not using this moving forward
    if (type==ui_t_window) {
        if (window_title_side==ui_up) ly+=window_title_size
    }


    //update children recursively
    i=0 repeat (ds_list_size(children)) {
        if (!ui_update_inner(ds_list_find_value(children,i))) exit
    i+=1}


    //for fitcontents, we resize to fit the contents
    if (overflow==ui_over_fitcontents) {
        width=max(width,lx+lph+margin)
        height=max(height,ly+lh+lp+margin)
    }


    //layout resolver
    if (parent!=noone) {
        parent.lh=max(parent.lh,height+max(padding,parent.lpv))
        parent.lp=max(parent.lp,padding)
        if (type==ui_t_break) {
            //break a line
            parent.lx=parent.lxi
            parent.ly+=parent.lh
            parent.lh=0
            parent.lpv=parent.lp
            parent.lp=0
        } else {
            //add to line
            parent.lx+=width+max(padding,parent.lp)
            parent.lph=padding
        }
    }


    //handle focus
    focus=0
    if (global.__ui_event_focus) {
        if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
            global.__ui_event_focus=0
            focus=1
        }
    }


    //event firing
    if (script_exists(handler)) {
        if (global.__ui_event_mouse_left) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_left=0
                if (instance_exists(argument0)) script_execute(handler,id,"left click",mouse_x,mouse_y)
            }
        }
        if (global.__ui_event_mouse_left_rel) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_left_rel=0
                if (instance_exists(argument0)) script_execute(handler,id,"left release",mouse_x,mouse_y)
            }
        }
        if (global.__ui_event_mouse_right) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_right=0
                if (instance_exists(argument0)) script_execute(handler,id,"right click",mouse_x,mouse_y)
            }
        }
        if (global.__ui_event_mouse_right_rel) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_right_rel=0
                if (instance_exists(argument0)) script_execute(handler,id,"right release",mouse_x,mouse_y)
            }
        }
        if (global.__ui_event_mouse_scrollup) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_scrollup=0
                if (instance_exists(argument0)) script_execute(handler,id,"scroll up")
            }
        }
        if (global.__ui_event_mouse_scrolldown) {
            if (point_in_rectangle(mouse_x,mouse_y,x,y,x+width,y+height)) {
                global.__ui_event_mouse_scrolldown=0
                if (instance_exists(argument0)) script_execute(handler,id,"scroll down")
            }
        }


        //post-update handler
        if (instance_exists(argument0)) script_execute(handler,id,"end step")
    }
}

return instance_exists(argument0)
