///event_handler(element,event,[data])

with (argument[0]) switch (argument[1]) {
    case "step": {
        if (state=="grab") {
            x=mouse_x-offset_x
            y=mouse_y-offset_y
        }
        if (name=="close") {
            if (state=="down") and not (focus) state="up"
        }
    }break
    case "left click": {
        if (name=="title") {
            parent.state="grab"
            parent.offset_x=mouse_x-parent.x
            parent.offset_y=mouse_y-parent.y
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
