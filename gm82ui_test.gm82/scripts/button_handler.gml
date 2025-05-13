with (argument[0])
switch (argument[1]) {
    case "left click": {
        state="down"
    }break
    case "left release": {
        state="up"
        show_message("activate")
    }break
}
