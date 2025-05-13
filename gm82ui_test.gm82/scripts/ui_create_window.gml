///ui_create_window(width,height,caption,[handler])
var ui;

if (argument_count<2) {show_error("woaps",0) return noone}

ui=ui_create(ui_t_panel,window_handler)
ui_set_name(ui,"window")
ui_set_size(ui,argument[0],argument[1],0,0)

instance_activate_object(ui)

if (argument_count>3) ui.handler=argument[3]

button=ui_create_button(argument[2],window_handler)
ui_set_size(button,argument[0]-24,24,0,0)
ui_set_style(button,styler_button)
ui_set_name(button,"title")
instance_activate_object(button)
button.color=$880088
ui_append_child(ui,button)

button=ui_create_button("",window_handler,sprIcons,0)
ui_set_size(button,24,24,0,0)
ui_set_name(button,"close")
ui_set_alt(button,"Close","Closes the window.")
ui_set_style(button,styler_button)
ui_append_child(ui,button)

ui_append_child(ui,ui_create(ui_t_break))


return ui
