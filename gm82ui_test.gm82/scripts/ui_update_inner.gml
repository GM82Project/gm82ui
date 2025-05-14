///ui_update_inner(element,x,y,rotation,xscale,yscale)
var i;

if (!instance_exists(argument0)) return false

with (argument0) {
    //pre-update handler
    if (script_exists(handler)) script_execute(handler,id,"step")


    //reset to defaults
    if (parent==noone) {
        //master
        if (argument1!=ui_preserve) x=argument1
        if (argument2!=ui_preserve) y=argument2
        if (argument3!=ui_preserve) image_angle=argument3
        if (argument4!=ui_preserve) image_xscale=argument4
        if (argument5!=ui_preserve) image_yscale=argument5

        tmouse_x=x+pivot_pos_x(mouse_x-x,mouse_y-y,-image_angle)/image_xscale
        tmouse_y=y+pivot_pos_y(mouse_x-x,mouse_y-y,-image_angle)/image_yscale
    } else {
        x=parent.lx+padding
        y=parent.ly+padding
        tmouse_x=parent.tmouse_x
        tmouse_y=parent.tmouse_y
    }

    lxi=x+margin
    lyi=y+margin
    lx=lxi
    ly=lyi
    lh=0 //line height
    lp=0 //line pad
    lph=0 //last pad hor
    lpv=0 //last pad vert

    if (setwidth==ui_fit_contents) width=0 else width=setwidth
    if (setheight==ui_fit_contents) height=0 else height=setheight

    //for fill, we use the remaining space in the parent's box
    if (setwidth==ui_fill_space) width=parent.width-(x-parent.x)

    
    //update children recursively
    i=0 repeat (ds_list_size(children)) {
        if (!ui_update_inner(ds_list_find_value(children,i),argument1,argument2,argument3,argument4,argument5)) exit
    i+=1}


    //for fitcontents, we resize to fit the contents
    if (setwidth==ui_fit_contents) width=max(width,lx+lph+margin-x)
    if (setheight==ui_fit_contents) height=max(height,ly+lh+lp+margin-y)


    //layout resolver
    if (parent!=noone) {
        if (parent.direction1==ui_right) {
            parent.lh=max(parent.lh,height+max(padding,parent.lpv))            
        }
        if (parent.direction1==ui_down) {
            parent.lh=max(parent.lh,width+max(padding,parent.lpv))            
        }
        parent.lp=max(parent.lp,padding)
        if (type==ui_t_break) {
            //break a line
            if (parent.direction1==ui_right) {
                parent.lx=parent.lxi
                parent.ly+=parent.lh
                parent.lh=0
                parent.lpv=parent.lp
                parent.lp=0
            }
            if (parent.direction1==ui_down) {
                parent.ly=parent.lyi
                parent.lx+=parent.lh
                parent.lh=0
                parent.lpv=parent.lp
                parent.lp=0
            }
        } else {
            //add to line
            if (parent.direction1==ui_right) {
                parent.lx+=width+max(padding,parent.lp)
                parent.lph=padding
            }
            if (parent.direction1==ui_down) {
                parent.ly+=height+max(padding,parent.lp)
                parent.lph=padding
            }
        }
    }


    //handle focus
    focus=0
    if (global.__ui_event_focus) {
        if (point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)) {
            global.__ui_event_focus=0
            focus=enabled
        }
    }


    //event firing
    if (script_exists(handler)) if (instance_exists(argument0)) if (enabled) {
        if (global.__ui_event_mouse_left) {
            if (point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"left click",tmouse_x,tmouse_y)) global.__ui_event_mouse_left=0
            }
        }
        if (global.__ui_event_mouse_left_rel) {
            if (point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"left release",tmouse_x,tmouse_y)) global.__ui_event_mouse_left_rel=0
            }
        }
        if (global.__ui_event_mouse_right) {
            if (point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"right click",tmouse_x,tmouse_y)) global.__ui_event_mouse_right=0
            }
        }
        if (global.__ui_event_mouse_right_rel) {
            if (point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"right release",tmouse_x,tmouse_y)) global.__ui_event_mouse_right_rel=0
            }
        }
        if (global.__ui_event_mouse_scrollup) {
            if (point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"scroll up")) global.__ui_event_mouse_scrollup=0
            }
        }
        if (global.__ui_event_mouse_scrolldown) {
            if (point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"scroll down")) global.__ui_event_mouse_scrolldown=0
            }
        }


        //post-update handler
        if (instance_exists(argument0)) script_execute(handler,id,"end step")
    }
}

return instance_exists(argument0)
