var i,mx,my,l;

with (argument0) {
    //grab focus if nothing has focus
    var check;check=true
    with (global.__ui_obj) if (keyfocus) {check=false}
    if (check and argument0.cantab) argument0.keyfocus=true

    //pre-update handler
    __gm82ui_fire_handler("step",noone)


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
        __gm82ui_process_inner(ds_list_find_value(children,i))
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
                if (cantab) __gm82ui_takeyfocus()
            }

            if (handler!=noone) {
                __gm82ui_eat_message("left click")
                __gm82ui_eat_message("left release")
                __gm82ui_eat_message("right click")
                __gm82ui_eat_message("right release")
                __gm82ui_eat_message("scroll up")
                __gm82ui_eat_message("scroll down")
            }
        }

        if (keyfocus) {
            __gm82ui_eat_message("accept")
            __gm82ui_eat_message("accept press")
            __gm82ui_eat_message("accept release")
            __gm82ui_eat_message("menu")
            __gm82ui_eat_message("menu press")
            __gm82ui_eat_message("menu release")

            var tab;tab=__gm82ui_delete_message("tab")-__gm82ui_delete_message("back tab")
            if (tab!=0) {
                var newtab,find; newtab=taborder
                initial=id find=id
                do {
                    newtab=modwrap(newtab+tab,0,topowner.tabcount)
                    with (global.__ui_obj) if (topowner==other.topowner && taborder==newtab) {
                        __gm82ui_takeyfocus()
                        find=id
                        break
                    }
                } until (find.cantab==true and find!=id) or (find==initial)
            }
        }
    }

    __gm82ui_fire_handler("end step",noone)
}
