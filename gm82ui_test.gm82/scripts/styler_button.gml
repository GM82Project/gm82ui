///test_styler(element)

with (argument0) {
    down=(state!="up")
    draw_button_ext(x,y,width,height,!down,image_blend)
    if (type==ui_t_button) if (button_sprite!=noone) draw_sprite(button_sprite,button_frame,x+width div 2+down,y+height div 2+down)
    draw_set_halign(1)
    draw_set_valign(1)
    draw_set_color(global.ui_col_text)
    draw_set_font(font0)
    draw_text(x+width div 2,y+height div 2-1,text)
    draw_set_halign(0)
    draw_set_valign(0)
    draw_set_color($ffffff)
}
