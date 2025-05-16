instance_activate_object(argument0)

with (argument0) {
    var i;i=0 repeat (ds_list_size(children)) {
        __gm82ui_destroy_inner(ds_list_find_value(children,i))
    i+=1}

    ds_list_destroy(children)
    instance_destroy()
}
