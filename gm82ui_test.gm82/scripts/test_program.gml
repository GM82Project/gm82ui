if (argument0=="create") {
    ui=ui_create(ui_t_container)

    panel=ui_create(ui_t_panel)
        ui_set_style(panel,test_styler)
        ui_set_size(panel,200,150,0)
        ui_set_format(panel,0,false,ui_over_spill)
    ui_append_child(ui,panel)

    button=ui_create(ui_t_button)
        ui_set_style(button,test_styler)
        ui_set_size(button,64,24,4)
        ui_set_text(button,"Button")
    ui_append_child(panel,button)
}
if (argument0=="step") {
    ui_update(ui)
}
if (argument0=="draw") {
    ui_draw(ui)
}
