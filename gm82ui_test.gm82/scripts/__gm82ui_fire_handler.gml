if (handler!=noone) {
    if (global.__ui_in_handler) show_error("error in ui stack: handler recursion.",0)
    else {
        global.__ui_in_handler=true
        ret=script_execute(handler,argument0,argument1)
        global.__ui_in_handler=false
        return ret
    }
}

return false
