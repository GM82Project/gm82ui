///ui_draw_inner(element)
var i;

with (argument0) {
    if (!enabled) exit

    if (script_exists(style)) script_execute(style,id)

    if (focus) {
        global.__ui_alt=alt
        global.__ui_help=help
    }

    i=0 repeat (ds_list_size(children)) {
        ui_draw_inner(ds_list_find_value(children,i))
    i+=1}
}
