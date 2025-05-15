if (argument0=="create") {
    ui_init()

    window=ui_create_window(400,300,"Window",window_handler)

    panel=ui_create(ui_t_panel)
    ui_set_size(panel,ui_fill_space,ui_fit_contents,4,0)
    ui_set_style(panel,styler_button)
    ui_set_custom(panel,"button_sprite",noone)
    ui_set_custom(panel,"color",global.ui_col_main)
    ui_append_child(window,panel)

    button=ui_create_button("Button1",button_handler)
        ui_set_style(button,styler_button)
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 1","yep that's a button 1")
    ui_append_child(panel,button)

    ui_append_child(panel,ui_t_break)

    button=ui_create_button("Button2",button_handler)
        ui_set_style(button,styler_button)
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 2","yep that's a button 2")
        ui_set_name(button,"button 2")
    ui_append_child(panel,button)

    button=ui_create_button("Button3",button_handler)
        ui_set_style(button,styler_button)
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 3","yep that's a button 3")
    ui_append_child(panel,button)

    ui_compute_layout(window)
}
if (argument0=="draw") {
    ui_push_default_mouse_messages()
    t=get_timer()
    global.move_window=false
    ui_process_messages(window)

    if (global.move_window) ui_compute_layout(window)

    room_caption=string((get_timer()-t)/1000) +"ms"
    ui_draw(window,styler_tooltip)
}
