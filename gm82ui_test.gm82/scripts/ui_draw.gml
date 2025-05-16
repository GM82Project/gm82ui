///ui_draw(ui,[tooltip_handler])

instance_activate_object(argument[0])
if (!instance_exists(argument[0])) exit

global.__ui_alt=""

instance_activate_object(global.__ui_obj)

with (argument0) {
    if (layout_stale) ui_compute_layout(self)
    d3d_transform_stack_push()
    d3d_transform_add_translation(-x,-y,0)
    d3d_transform_add_scaling(image_xscale,image_yscale,1)
    d3d_transform_add_rotation_z(image_angle)
    d3d_transform_add_translation(x,y,0)
    ui_draw_inner(id)
    d3d_transform_stack_pop()
}

instance_deactivate_object(global.__ui_obj)

if (global.__ui_alt!="") {
    script_execute(argument[1],global.__ui_alt)
}
//if (global.__ui_help!="") draw_text(8,room_height-20,global.__ui_help)
