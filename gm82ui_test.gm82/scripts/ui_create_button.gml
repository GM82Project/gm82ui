///ui_create_button(text,handler,[sprite])
var ui;

if (argument_count<2) {show_error("oops",0) return noone}

ui=ui_create(ui_t_button)

instance_activate_object(ui)

ui.text=argument[0]
ui.handler=argument[1]
if (argument_count>2) ui.button_sprite=argument[2]
ui.color=global.ui_col_main
ui.state="up"

instance_deactivate_object(ui)

return ui
