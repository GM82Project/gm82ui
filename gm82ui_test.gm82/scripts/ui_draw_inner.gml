with (argument0) {
    if (style!=noone) script_execute(style,id)

    if (focus) global.__ui_alt=alt

    var i;i=0 repeat (ds_list_size(children)) {
        ui_draw_inner(ds_list_find_value(children,i))
    i+=1}
}
