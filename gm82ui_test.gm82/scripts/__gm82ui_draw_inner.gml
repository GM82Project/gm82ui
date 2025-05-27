with (argument0) {
    if (type!=ui_t_break) {
        if (style==ui_default) __gm82ui_default_styler(self)
        else if (style!=noone) script_execute(style,self)

        if (keyboard_check(vk_f8)) draw_rectangle(x,y,x+width,y+height,1)

        if (focus) {
            global.__ui_alt=alt
            global.__ui_help=help
        }

        var i;i=0 repeat (ds_list_size(children)) {
            __gm82ui_draw_inner(ds_list_find_value(children,i))
        i+=1}
    }
}
