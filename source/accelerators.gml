#define __gm82ui_button_handler
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
        case "out of focus": {
            if (state=="down") {
                state="up"
            }
        }break
    }

    return ui_default_handler(argument0,argument1)


#define ui_create_button
    ///ui_create_button(text,[handler,[sprite,frame]])
    var ui;

    if (argument_count!=1 and argument_count!=2 and argument_count!=4) {
        show_error("In function ui_create_button: wrong number of arguments ("+string(argument_count)+")",0)
        return noone
    }

    ui=ui_create(ui_t_button)

    instance_activate_object(ui)

    ui.state="up"
    ui.button_sprite=noone

    ui.text=argument[0]
    ui.handler=ui_default
    if (argument_count>1) {
        ui.handler=argument[1]
    }
    if (argument_count==4) {
        ui.button_sprite=argument[2]
        ui.button_frame=argument[3]
    }

    instance_deactivate_object(ui)

    return ui
//
//