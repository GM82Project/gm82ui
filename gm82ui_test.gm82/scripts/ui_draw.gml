///ui_draw(ui,[tooltip_handler])

instance_activate_object(argument[0])
if (!instance_exists(argument[0])) exit

global.__ui_alt=""

instance_activate_object(global.__ui_obj)
ui_draw_inner(argument0)
instance_deactivate_object(global.__ui_obj)

if (global.__ui_alt!="") {
    script_execute(argument[1],global.__ui_alt)
}
//if (global.__ui_help!="") draw_text(8,room_height-20,global.__ui_help)
