///ui_create_window(title_side,title_size,[handler])
var ui;

if (argument_count<2) {show_error("woaps",0) return noone}

ui=ui_create(ui_t_window)

instance_activate_object(ui)

ui.window_title_side=argument[0]
ui.window_title_size=argument[1]
if (argument_count>2) ui.handler=argument[2]

ui.overflow=ui_over_fitcontents

instance_deactivate_object(ui)

return ui
