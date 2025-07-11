//window_handler(event,data)

var data;data=argument1

switch (argument0) {
    case "step": {
        if (name=="title") with (parent) if (state=="grab") {
            window_mouse_set(
                window_mouse_get_x()+(keyboard_check(vk_right)-keyboard_check(vk_left))*4,
                window_mouse_get_y()+(keyboard_check(vk_down)-keyboard_check(vk_up))*4,
            )
            ui_set_pos(self,tmouse_x-offset_x,tmouse_y-offset_y)
            if (ui_has_message("left release")) state="none"
        }
        if (name=="close") {
            if (state=="down") and not (focus) state="up"
        }
    }break

    case "left click": {
        if (name=="title") with (parent) {
            state="grab"
            offset_x=tmouse_x-x
            offset_y=tmouse_y-y
            return true
        }
        if (name=="close") {
            state="down"
            return true
        }
    }break
    case "left release": {
        if (name=="close") {
            if (state=="down") {
                ui_destroy(parent)
                return true
            }
        }
    }break

    case "right click": case "menu press": {
        if (name=="title") {
            var m;m=show_menu("Move|Close",-1)
            if (m==0) with (parent) {
                state="grab"
                offset_x=other.width/2
                offset_y=other.height/2
                return true
            }
            if (m==1) {ui_destroy(parent)}
            return true
        }
    }break
}

return ui_default_handler(argument0,argument1)
