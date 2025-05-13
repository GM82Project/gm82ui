///test_styler_label(element)
var ui,dx,dy,dw,dh,up;

ui=argument0

dx=ui.x
dy=ui.y
dw=ui.width
dh=ui.height

draw_set_valign(1)
draw_set_color(global.ui_col_text)
draw_set_font(font0)
draw_text(dx,dy+dh div 2-1,ui.text)
draw_set_valign(0)
draw_set_color($ffffff)
