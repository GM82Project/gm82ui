if (argument0=="create") {
    ui_init()

    window=ui_create(ui_t_panel,window_handler)
    ui_set_name(window,"window")
    ui_set_size(window,400,300,0,0)
    ui_set_format(window,ui_no,ui_over_hidden,ui_over_spill,ui_right,ui_down)

    var title;title=create_button("Window",window_handler)
    ui_set_size(title,400-24,24,0,0)
    ui_set_style(title,styler_button)
    ui_set_name(title,"title")
    ui_set_blend(title,$880088,1)
    ui_append_child(window,title)

    var button;button=create_button("",window_handler,sprIcons,0)
    ui_set_size(button,24,24,0,0)
    ui_set_name(button,"close")
    ui_set_alt(button,"Close","Closes the window.")
    ui_set_style(button,styler_button)
    ui_append_child(window,button)

    ui_append_child(window,ui_t_break)

    panel=ui_create(ui_t_panel)
    ui_set_size(panel,ui_fill_space,ui_fit_contents,4,0)
    ui_set_style(panel,styler_button)
    ui_append_child(window,panel)

    button=create_button("Button1",button_handler)
        ui_set_style(button,styler_button)
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 1","yep that's a button 1")
    ui_append_child(panel,button)

    ui_append_child(panel,ui_t_break)

    button=create_button("Button2",button_handler)
        ui_set_style(button,styler_button)
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 2","yep that's a button 2")
        ui_set_name(button,"button 2")
    ui_append_child(panel,button)

    button=create_button("Button3",button_handler)
        ui_set_style(button,styler_button)
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 3","yep that's a button 3")
    ui_append_child(panel,button)
}
if (argument0=="draw") {
    t=get_timer()
        ui_push_default_mouse_messages()
        ui_process_messages(window)
        ui_draw(window,styler_tooltip)
    room_caption=string((get_timer()-t)/1000) +"ms"
}
