///test_styler(element)
var ui,dx,dy,dw,dh,up;

ui=argument0

dx=ui.x
dy=ui.y
dw=ui.width
dh=ui.height

up=ui.state=="up"

draw_set_color($ff)
draw_rectangle(dx,dy,dx+dw-1,dy+dh-1,0)
draw_set_color($ffffff)
draw_rectangle(dx+4,dy+4,dx+dw-4-1,dy+dh-4-1,0)

//draw_button(dx,dy,dx+dw,dy+dh,up)
draw_set_halign(1)
draw_set_valign(1)
draw_set_color(0)
draw_text(dx+dw div 2,dy+dh div 2,ui.text)
draw_set_halign(0)
draw_set_valign(0)
draw_set_color($ffffff)
