//button_handler(event,data)

var data;data=argument1

switch (argument0) {
    case "step": {
        if (state=="down") and not (focus) and not (keyfocus) state="up"
    }break

    case "left click": case "accept press": {
        state="down"
        return true
    }break
    case "left release": case "accept release": {
        if (state=="down") {
            state="up"
            return true
        }
    }break
}

return ui_default_handler()
