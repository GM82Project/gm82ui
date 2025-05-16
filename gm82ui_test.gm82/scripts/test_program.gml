if (argument0=="create") {
    window=ui_create(ui_t_panel,window_handler)
        ui_set_style(window,noone)
        ui_set_size(window,400,300)
        ui_set_format(window,ui_no,ui_over_hidden,ui_over_spill,ui_right,ui_down)

    title=ui_append_child(window,create_button("Window",window_handler))
        ui_set_size(title,400-24,24)
        ui_set_name(title,"title")
        ui_set_blend(id,$880088,1)

    button=ui_append_child(window,create_button("",window_handler,sprIcons,0))
        ui_set_size(button,24,24)
        ui_set_name(button,"close")
        ui_set_alt(button,"Close","Closes the window.")

    ui_append_child(window,ui_t_break)

    panel=ui_append_child(window,ui_t_panel)
        ui_set_size(panel,ui_fill_space,ui_fit_contents,4,0)

    button=ui_append_child(panel,create_button("Button1"))
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 1","yep that's a button 1")

    ui_append_child(panel,ui_t_break)

    button=ui_append_child(panel,create_button("Button2"))
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 2","yep that's a button 2")

    button=ui_append_child(panel,create_button("Button3"))
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 3","yep that's a button 3")
}
if (argument0=="draw") {
    ui_push_default_mouse()
    ui_process_messages(window)
    ui_draw(window)
    ui_draw_default_tooltip(mouse_x,mouse_y+32)
    draw_text(10,room_height-30,ui_get_help())
}
