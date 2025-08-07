if (argument0=="create") {
    window=ui_create(ui_t_panel,window_handler)
        ui_set_pos(window,200,200)
        ui_set_style(window,noone)
        ui_set_size(window,400,300)
        ui_set_format(window,ui_no,ui_left,ui_down)

    button=ui_append_child(window,ui_create_button("",window_handler,sprIcons,0))
        ui_set_size(button,24,24)
        ui_set_name(button,"close")
        ui_set_alt(button,"Close","Closes the window.")

    title=ui_append_child(window,ui_create_button("Window",window_handler))
        ui_set_size(title,ui_fill_space,24)
        ui_set_name(title,"title")
        ui_set_blend(title,$880088,1)

    ui_append_child(window,ui_t_break)

    panel=ui_append_child(window,ui_t_panel)
        ui_set_size(panel,ui_fill_space,ui_fit_contents,4,0)
        ui_set_format(panel,ui_no,ui_right,ui_down)

    button=ui_append_child(panel,ui_create_button("Button1"))
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 1","yep that's a button 1")
        ui_set_keyboard_enabled(button,true)

    check=ui_append_child(panel,ui_create(ui_t_check))
        ui_set_size(check,120,24,0,4)
        ui_set_text(check,"Checkbox")
        ui_set_keyboard_enabled(check,true)

    ui_append_child(panel,ui_t_break)

    button=ui_append_child(panel,ui_create_button("Buttomn2",ui_default,sprIcons,0))
        ui_set_size(button,128,24,0,4)
        ui_set_alt(button,"button 2","yep that's a button 2")
        ui_set_keyboard_enabled(button,true)

    button=ui_append_child(panel,ui_create_button("Button3"))
        ui_set_size(button,80,24,0,4)
        ui_set_alt(button,"button 3","yep that's a button 3")
        ui_set_keyboard_enabled(button,true)

    ui_append_child(panel,ui_t_break)

    radiogroup=ui_append_child(panel,ui_t_panel)
        ui_set_size(radiogroup,ui_fit_contents,ui_fit_contents)
        ui_set_style(radiogroup,noone)

    radio=ui_append_child(radiogroup,ui_create(ui_t_radio))
        ui_set_size(radio,120,24,0,4)
        ui_set_text(radio,"Option 1")
        ui_set_keyboard_enabled(radio,true)

    ui_append_child(radiogroup,ui_t_break)
    radio=ui_append_child(radiogroup,ui_create(ui_t_radio))
        ui_set_size(radio,120,24,0,4)
        ui_set_text(radio,"Option 2")
        ui_set_state(radio,"checked")
        ui_set_keyboard_enabled(radio,true)

    ui_append_child(radiogroup,ui_t_break)
    radio=ui_append_child(radiogroup,ui_create(ui_t_radio))
        ui_set_size(radio,120,24,0,4)
        ui_set_text(radio,"Option 3")
        ui_set_keyboard_enabled(radio,true)

    image=ui_create(ui_t_panel)
    ui_set_size(image,104,104,0,4)
    ui_set_style(image,image_styler)
    ui_set_variable(image,"src",background1_gm82)
    ui_append_child(panel,image)


    avg=0
}
if (argument0=="draw") {
    t=get_timer()
    ui_push_default_messages()
    ui_process_messages(window)
    avg=mean(avg,get_timer()-t)

    ui_draw(window)
    ui_draw_default_tooltip(mouse_x,mouse_y+32)

    draw_text(10,room_height-30,string(avg)+" | "+ui_get_help())
}
