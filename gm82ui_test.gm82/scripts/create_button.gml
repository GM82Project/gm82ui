///create_button(text,[handler,[sprite,frame]])
var ui;

if (argument_count!=1 and argument_count!=2 and argument_count!=4) {show_error("oops",0) return noone}

ui=ui_create(ui_t_button)

instance_activate_object(ui)

ui.state="up"
ui.button_sprite=noone

ui.text=argument[0]
ui.handler=button_handler
if (argument_count>1) {
    if (argument[1]!=ui_default)
        ui.handler=argument[1]
}
if (argument_count==4) {
    ui.button_sprite=argument[2]
    ui.button_frame=argument[3]
}

instance_deactivate_object(ui)

return ui
