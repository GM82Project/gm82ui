if (handler!=noone) {
    global.__ui_in_handler=true
    ret=script_execute(handler,argument0,argument1)
    global.__ui_in_handler=false
    return ret
}

return false
