if (argument0=="create") {
    ui_init()

    ui=ui_create(ui_t_container)

    panel=ui_create(ui_t_panel)
        ui_set_style(panel,test_styler)
        ui_set_size(panel,200,150,4,0)
        ui_set_format(panel,0,false,ui_over_fitcontents,ui_right)
        ui_set_alt(panel,"","panel")
    ui_append_child(ui,panel)

    button=ui_create(ui_t_button,test_handler)
        ui_set_style(button,test_styler)
        ui_set_size(button,80,24,0,4)
        ui_set_text(button,"Button1")
        ui_set_alt(button,"button 1","yep that's a button 1")
    ui_append_child(panel,button)

    ui_append_child(panel,ui_create(ui_t_break))

    button=ui_create(ui_t_button,test_handler)
        ui_set_style(button,test_styler)
        ui_set_size(button,80,24,0,4)
        ui_set_text(button,"Button2")
        ui_set_alt(button,"button 2","yep that's a button 2")
    ui_append_child(panel,button)

    button=ui_create(ui_t_button,test_handler)
        ui_set_style(button,test_styler)
        ui_set_size(button,80,24,0,4)
        ui_set_text(button,"Button3")
        ui_set_alt(button,"button 3","yep that's a button 3")
    ui_append_child(panel,button)
}
if (argument0=="step") {
    t=get_timer()
    ui_update(ui)
    room_caption=string(get_timer()-t)
}
if (argument0=="draw") {
    ui_draw(ui)
}
