ui_push_message("mouse",mouse_x,mouse_y)
ui_push_message("focus")

if (mouse_check_button_pressed(mb_left)) ui_push_message("left click")
if (mouse_check_button_pressed(mb_right)) ui_push_message("right click")
if (mouse_check_button_released(mb_left)) ui_push_message("left release")
if (mouse_check_button_released(mb_right)) ui_push_message("right release")

if (mouse_wheel_up()) ui_push_message("scroll up")
if (mouse_wheel_down()) ui_push_message("scroll down")
