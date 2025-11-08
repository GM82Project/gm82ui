#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
test_program("create")

debug=false
#define Other_30
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=332
invert=0
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
test_program("draw")
#define KeyPress_119
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
debug=!debug

ui_settings(ui_set_debugmode,debug)
