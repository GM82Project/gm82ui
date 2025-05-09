///test_styler(element)
var element,dx,dy,dw,dh,up;

element=argument0

dx=dsmap(element,"x")
dy=dsmap(element,"y")
dw=dsmap(element,"width")
dh=dsmap(element,"height")

up=dsmap(element,"state")=="up"

draw_set_color($c0c0c0)
draw_button(dx,dy,dx+dw,dy+dh,up)
draw_set2(1,1)
draw_set_color(0)
draw_text(dx+dw div 2,dy+dh div 2,dsmap(element,"text"))
draw_reset()
