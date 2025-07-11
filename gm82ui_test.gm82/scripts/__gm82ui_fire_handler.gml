if (handler!=noone) {
    if (global.__gm82ui_in_handler) show_error("error in ui stack: handler recursion.",0)
    else {
        global.__gm82ui_in_handler=true
        ret=script_execute(handler,argument0,argument1)
        global.__gm82ui_in_handler=false
        return ret
    }
}

return false
