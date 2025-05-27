//window_handler(event,data)

var data;data=argument1

switch (argument0) {
    case "step": {
        if (name=="title") with (parent) if (state=="grab") {
            ui_set_pos(self,tmouse_x-offset_x,tmouse_y-offset_y)
            if (!ui_has_message("left button")) state="none"
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
}

return false
