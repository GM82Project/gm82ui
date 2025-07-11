var data;data=argument1

switch (type) {
    case ui_t_radio: {
        switch (argument0) {
            case "left click": case "accept press": {
                with (global.__gm82ui_obj) if (type==ui_t_radio) and (parent==other.parent) {
                    state="none"
                }
                state="checked"
                return true
            }break
        }
    }break
    case ui_t_check: {
        switch (argument0) {
            case "left click": case "accept press": {
                if (state=="checked") state="none"
                else state="checked"
                return true
            }break
        }
    }break
}

return false
