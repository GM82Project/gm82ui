///ui_create_window(title_side,title_size,[handler])
var ui;

if (argument_count<2) {show_error("woaps",0) return noone}

ui=ui_create(ui_t_container,window_handler)
ui_set_name(ui,"window")

global.test=ui

instance_activate_object(ui)

ui.window_title_side=argument[0]
ui.window_title_size=argument[1]
if (argument_count>2) ui.handler=argument[2]

ui.overflow=ui_over_fitcontents

instance_deactivate_object(ui)

button=ui_create_button("Window",window_handler)
ui_set_size(button,400-24,24,0,0)
ui_set_style(button,test_styler)
ui_set_name(button,"title")
instance_activate_object(button)
button.color=$880088
ui_append_child(ui,button)

button=ui_create_button("X",window_handler)
ui_set_size(button,24,24,0,0)
ui_set_name(button,"close")
ui_set_style(button,test_styler)
ui_append_child(ui,button)

ui_append_child(ui,ui_create(ui_t_break))



return ui
