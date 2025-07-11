if (keyboard_check(vk_enter) or keyboard_check(vk_space)) ui_push_message("accept")
if (keyboard_check_pressed(vk_enter) and not keyboard_check(vk_space)) or (keyboard_check_pressed(vk_space) and not keyboard_check(vk_enter)) ui_push_message("accept press")
if (keyboard_check_released(vk_enter) and not keyboard_check(vk_space)) or (keyboard_check_released(vk_space) and not keyboard_check(vk_enter)) ui_push_message("accept release")

if (keyboard_check(vk_menu)) ui_push_message("menu")
if (keyboard_check_pressed(vk_menu)) ui_push_message("menu press")
if (keyboard_check_released(vk_menu)) ui_push_message("menu release")

if (keyboard_check_pressed(vk_pageup)) ui_push_message("page up")
if (keyboard_check_pressed(vk_pagedown)) ui_push_message("page down")

if (keyboard_check_pressed(vk_tab)) {
    if (keyboard_check(vk_shift)) ui_push_message("back tab") else ui_push_message("tab")
}
