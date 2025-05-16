//styler(element,[data])

with (argument0) {
    draw_set_valign(1)
    draw_set_color(global.ui_col_text)
    draw_set_font(font0)

    if (type==ui_t_label) {
        draw_text(x,y+height div 2-1,text)
    } else {
        down=2*(state!="up")

        if (image_blend!=noone) {
            draw_rect(x,y,width,height,image_blend)
        }

        draw_sprite_part(global.ui_buttontex,down,0,0,4,4,x,y)
        draw_sprite_part(global.ui_buttontex,down,76,0,4,4,x+width-4,y)
        draw_sprite_part(global.ui_buttontex,down,0,21,4,4,x,y+height-4)
        draw_sprite_part(global.ui_buttontex,down,76,21,4,4,x+width-4,y+height-4)

        draw_sprite_part_ext(global.ui_buttontex,down,5,0,70,4,x+4,y,(width-8)/70,1,$ffffff,1)
        draw_sprite_part_ext(global.ui_buttontex,down,5,21,70,4,x+4,y+height-4,(width-8)/70,1,$ffffff,1)
        draw_sprite_part_ext(global.ui_buttontex,down,0,5,4,15,x,y+4,1,(height-8)/15,$ffffff,1)
        draw_sprite_part_ext(global.ui_buttontex,down,76,5,4,15,x+width-4,y+4,1,(height-8)/15,$ffffff,1)

        if (type==ui_t_button) if (button_sprite!=noone)
            draw_sprite(button_sprite,button_frame,x+width div 2+down,y+height div 2+down)
        draw_set_halign(1)
        draw_text(x+width div 2,y+height div 2-1,text)
        draw_set_halign(0)
    }

    draw_set_valign(0)
    draw_set_color($ffffff)
}
