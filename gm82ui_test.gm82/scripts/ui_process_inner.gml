///ui_process_inner(element)
var i;

if (!instance_exists(argument0)) return false

with (argument0) {
    //pre-update handler
    if (script_exists(handler)) script_execute(handler,id,"step")


    //reset to defaults
    if (parent==noone) {
        //master
        tmouse_x=x+pivot_pos_x(mouse_x-x,mouse_y-y,-image_angle)/image_xscale
        tmouse_y=y+pivot_pos_y(mouse_x-x,mouse_y-y,-image_angle)/image_yscale
    } else {
        tmouse_x=parent.tmouse_x
        tmouse_y=parent.tmouse_y
    }


    //update children recursively
    i=0 repeat (ds_list_size(children)) {
        if (!ui_process_inner(ds_list_find_value(children,i))) exit
    i+=1}


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
        mouse_collision=point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)
        if (global.__ui_event_mouse_left) {
            if (mouse_collision) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"left click",tmouse_x,tmouse_y)) global.__ui_event_mouse_left=0
            }
        }
        if (global.__ui_event_mouse_left_rel) {
            if (mouse_collision) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"left release",tmouse_x,tmouse_y)) global.__ui_event_mouse_left_rel=0
            }
        }
        if (global.__ui_event_mouse_right) {
            if (mouse_collision) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"right click",tmouse_x,tmouse_y)) global.__ui_event_mouse_right=0
            }
        }
        if (global.__ui_event_mouse_right_rel) {
            if (mouse_collision) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"right release",tmouse_x,tmouse_y)) global.__ui_event_mouse_right_rel=0
            }
        }
        if (global.__ui_event_mouse_scrollup) {
            if (mouse_collision) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"scroll up")) global.__ui_event_mouse_scrollup=0
            }
        }
        if (global.__ui_event_mouse_scrolldown) {
            if (mouse_collision) {
                if (instance_exists(argument0)) if (script_execute(handler,id,"scroll down")) global.__ui_event_mouse_scrolldown=0
            }
        }


        //post-update handler
        if (instance_exists(argument0)) script_execute(handler,id,"end step")
    }
}

return instance_exists(argument0)
