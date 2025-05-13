///event_handler(element,event,[data])

with (argument[0])
switch (argument[1]) {
    case "step": {
        if (state=="grab") {
            x=mouse_x-offset_x
            y=mouse_y-offset_y
        }
    }break
    case "left click": {
        if (name=="title") {
            parent.state="grab"
            parent.offset_x=argument[2]-parent.x
            parent.offset_y=argument[3]-parent.y
        }
        if (name=="close") {
            state="down"
        }
    }break
    case "left release": {
        if (name=="title") {
            parent.state="none"
        }
        if (name=="close") {
            state="up"
            ui_destroy(parent)
        }
    }break
}
