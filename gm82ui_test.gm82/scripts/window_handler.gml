///event_handler(event,data)

var data;data=argument1

switch (argument0) {
    case "step": {
        if (state=="grab") {
            x=tmouse_x-offset_x
            y=tmouse_y-offset_y
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
        }
        if (name=="close") {
            state="down"
        }
        return true
    }break
    case "left release": {
        if (name=="title") {
            parent.state="none"
        }
        if (name=="close") {
            if (state=="down") {
                ui_destroy(parent)
            }
        }
        return true
    }break
}

return false
