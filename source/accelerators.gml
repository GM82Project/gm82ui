#define __gm82ui_button_handler
    var data;data=argument1

    switch (argument0) {
        case "left click": case "accept press": {
            state="down"
            return true
        }break
        case "left release": case "accept release": {
            if (state=="down") {
                state="up"
                if (button_click!=noone) script_execute(button_click,ui_b_accept)
                return true
            }
        }break
        case "right click": case "cancel press": {
            state="down"
            return true
        }break
        case "right release": case "cancel release": {
            if (state=="down") {
                state="up"
                if (button_click!=noone) script_execute(button_click,ui_b_cancel)
                return true
            }
        }break
        case "focus loss": {
            if (state=="down" and focus) {
                state="up"
            }
        }break
    }

    return ui_default_handler(argument0,argument1)


#define ui_create_button
    ///ui_create_button(text,script,[sprite,frame])
    var ui;

    if (argument_count!=2 and argument_count!=4) {
        show_error("In function ui_create_button: wrong number of arguments ("+string(argument_count)+")",0)
        return noone
    }
    
    if (argument[1]!=noone) if (!script_exists(argument[1])) {
        show_error("in function ui_create_button: invalid callback script id ("+string(argument[1])+")",0)
        return noone
    }

    ui=ui_create(ui_t_button)

    instance_activate_object(ui)

    ui.state="up"
    ui.button_sprite=noone

    ui.text=argument[0]
    ui.button_click=argument[1]
    ui.handler=ui_default
    
    if (argument_count==4) {
        ui.button_sprite=argument[2]
        ui.button_frame=argument[3]
    }

    instance_deactivate_object(ui)

    return ui
//
//