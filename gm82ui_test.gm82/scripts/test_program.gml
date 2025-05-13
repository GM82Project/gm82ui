if (argument0=="create") {
    ui_init()

    window=ui_create_window(ui_up,24)

    panel=ui_create(ui_t_panel)
    ui_set_size(panel,400,300,4,0)
    ui_set_style(panel,test_styler)
    ui_append_child(window,panel)

    button=ui_create_button("Button1",button_handler)
        ui_set_style(button,test_styler)
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 1","yep that's a button 1")
    ui_append_child(panel,button)

    ui_append_child(panel,ui_create(ui_t_break))

    button=ui_create_button("Button2",button_handler)
        ui_set_style(button,test_styler)
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 2","yep that's a button 2")
        ui_set_name(button,"button 2")
    ui_append_child(panel,button)

    button=ui_create_button("Button3",button_handler)
        ui_set_style(button,test_styler)
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 3","yep that's a button 3")
    ui_append_child(panel,button)
}
if (argument0=="step") {
    t=get_timer()
    ui_update(window)
    room_caption=string((get_timer()-t)/1000) +"ms"
}
if (argument0=="draw") {
    ui_draw(window)
}
