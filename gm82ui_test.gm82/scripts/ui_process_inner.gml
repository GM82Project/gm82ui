///ui_process_inner(element)
var i,mx,my,l;

with (argument0) {
    //pre-update handler
    ui_fire_handler("step",noone)


    //reset to defaults
    focus=false
    if (parent==noone) {
        //top-level parent
        if (ds_map_exists(global.__ui_messages,"mouse")) {
            l=ds_map_find_value(global.__ui_messages,"mouse")

            mx=ds_list_find_value(l,0)
            my=ds_list_find_value(l,1)

            ds_list_destroy(l)
            ds_map_delete(global.__ui_messages,"mouse")

            tmouse_x=x+pivot_pos_x(mx-x,my-y,-image_angle)/image_xscale
            tmouse_y=y+pivot_pos_y(mx-x,my-y,-image_angle)/image_yscale
        }
    } else {
        //child
        tmouse_x=parent.tmouse_x
        tmouse_y=parent.tmouse_y
    }


    //update children recursively
    i=0 repeat (ds_list_size(children)) {
        ui_process_inner(ds_list_find_value(children,i))
    i+=1}


    //handle events
    if (enabled) {
        //mouse collision
        if (point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)) {
            //focus
            if (ds_map_exists(global.__ui_messages,"focus")) {
                ds_list_destroy(ds_map_find_value(global.__ui_messages,"focus"))
                ds_map_delete(global.__ui_messages,"focus")
                focus=true
            }

            if (handler!=noone) {
                ui_eat_message("left click")
                ui_eat_message("left release")
                ui_eat_message("right click")
                ui_eat_message("right release")
                ui_eat_message("scroll up")
                ui_eat_message("scroll down")
            }
        }

        //handle keyboard events here
    }

    ui_fire_handler("end step",noone)
}
