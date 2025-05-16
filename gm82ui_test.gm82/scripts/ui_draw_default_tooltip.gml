///ui_draw_default_tooltip(x,y)
var w,h,dx,dy;

if (global.__ui_alt!="") {
    w=string_width(global.__ui_alt)+8
    h=24

    dx=argument0
    dy=argument1

    draw_rectangle_color(dx,dy,dx+w,dy+h,$c0ffff,$c0ffff,$c0ffff,$c0ffff,0)
    draw_rectangle_color(dx,dy,dx+w,dy+h,0,0,0,0,1)
    draw_set_valign(1)
    draw_set_color(0)
    draw_set_font(font0)
    draw_text(dx+4,dy+12-1,global.__ui_alt)
    draw_set_valign(0)
    draw_set_color($ffffff)
}
