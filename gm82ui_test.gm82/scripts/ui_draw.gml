///ui_draw(ui)

global.__ui_alt=""
global.__ui_help=""

instance_activate_object(global.__ui_obj)

if (!instance_exists(argument0)) exit

if (argument0.object_index!=global.__ui_obj) {
    show_error("in function ui_draw: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
    exit
}

with (argument0) {
    if (layout_stale) ui_set_transform(self,ui_default,ui_default,ui_default)
    d3d_transform_stack_push()
    d3d_transform_add_translation(-x,-y,0)
    d3d_transform_add_scaling(image_xscale,image_yscale,1)
    d3d_transform_add_rotation_z(image_angle)
    d3d_transform_add_translation(x,y,0)
    __gm82ui_draw_inner(self)
    d3d_transform_stack_pop()
}

instance_deactivate_object(global.__ui_obj)
