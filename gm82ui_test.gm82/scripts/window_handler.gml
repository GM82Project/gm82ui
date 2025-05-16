///event_handler(event,data)

var data;data=argument1

switch (argument0) {
    case "step": {
        if (name=="title") {
            with (parent) if (state=="grab") {
                x=tmouse_x-offset_x
                y=tmouse_y-offset_y
                layout_stale=true
                if (!ui_has_message("left button")) state="none"
            }
        }
        if (name=="close") {
            if (state=="down") and not (focus) state="up"
        }
    }break

    case "left click": {
        if (name=="title") {
            parent.state="grab"
            parent.offset_x=tmouse_x-parent.x
            parent.offset_y=tmouse_y-parent.y
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
