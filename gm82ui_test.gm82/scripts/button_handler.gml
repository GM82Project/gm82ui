//button_handler(event,data)

var data;data=argument1

switch (argument0) {
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
            return true
        }
    }break
}

return false
