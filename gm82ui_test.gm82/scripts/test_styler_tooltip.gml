///test_styler_tooltip(text)
var str,w,h,dx,dy;

str=argument0

w=string_width(str)+8
h=24

dx=mouse_x
dy=mouse_y+32

draw_rectangle_color(dx,dy,dx+w,dy+h,$c0ffff,$c0ffff,$c0ffff,$c0ffff,0)
draw_rectangle_color(dx,dy,dx+w,dy+h,0,0,0,0,1)
draw_set_valign(1)
draw_set_color(0)
draw_set_font(font0)
draw_text(dx+4,dy+12-1,str)
draw_set_valign(0)
draw_set_color($ffffff)
