///ui_create_window(width,height,caption,handler)

var window;window=ui_create(ui_t_panel,argument3)
ui_set_name(window,"window")
ui_set_size(window,argument0,argument1,0,0)
ui_set_layout(window,ui_no,ui_over_hidden,ui_over_spill,ui_right,ui_down)

var title;title=ui_create_button(argument[2],argument3)
ui_set_size(title,400-24,24,0,0)
ui_set_style(title,styler_button)
ui_set_name(title,"title")
ui_set_blend(title,$880088,1)
ui_append_child(window,title)

var button;button=ui_create_button("",argument3,sprIcons,0)
ui_set_size(button,24,24,0,0)
ui_set_name(button,"close")
ui_set_alt(button,"Close","Closes the window.")
ui_set_style(button,styler_button)
ui_append_child(window,button)

ui_append_child(window,ui_t_break)

return window
