with (argument0) {
    if (type!=ui_t_break) {
        if (style==ui_default) __gm82ui_default_styler(self)
        else if (style!=noone) script_execute(style,self)

        if (focus) {
            global.__gm82ui_alt=alt
            global.__gm82ui_help=help
        }

        var i;i=0 repeat (ds_list_size(children)) {
            __gm82ui_draw_inner(ds_list_find_value(children,i))
        i+=1}

        if (keyboard_check(vk_f8)) {
            draw_rectangle(x,y,x+width,y+height,1)
            if (direction1==ui_right) {x1=x+8 x2=x+width-8}
            if (direction1==ui_left) {x1=x+width-8 x2=x+8}
            if (direction2=ui_down) {y1=y+8 y2=y+height-8}
            if (direction2=ui_up) {y1=y+height-8 y2=y+8}

            draw_arrow(x1,y1,x2,y1,7)
            draw_arrow(x2,y1,x2,y2,7)
        }
    }
}
