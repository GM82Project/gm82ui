///event_handler(element,event,[data])

with (argument[0]) switch (argument[1]) {
    case "step": {
        if (state=="down") and not (focus) state="up"
    }break
    case "left click": {
        state="down"
        return true
    }break
    case "left release": {
        if (state=="down") {
            state="up"
            show_message("activate")
            return true
        }
    }break
}

return false
