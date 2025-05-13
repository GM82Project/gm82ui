instance_activate_object(argument0)
if (!instance_exists(argument0)) exit

global.__ui_alt=""
global.__ui_help=""

instance_activate_object(global.__ui_obj)
ui_draw_inner(argument0)
instance_deactivate_object(global.__ui_obj)

if (global.__ui_alt!="") {
    draw_rectangle(mouse_x,mouse_y+30,mouse_x+100,mouse_y+50,0)
    draw_set_color(0)
    draw_text(mouse_x,mouse_y+30,global.__ui_alt)
    draw_set_color($ffffff)
}
if (global.__ui_help!="") draw_text(8,room_height-20,global.__ui_help)
