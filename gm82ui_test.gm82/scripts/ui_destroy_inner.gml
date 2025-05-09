///ui_destroy_inner(element)
var i;

with (argument0) {
    i=0 repeat (ds_list_size(children)) {
        ui_destroy_inner(ds_list_find_value(children,i))
    i+=1}

    ds_list_destroy(children)
    instance_destroy()
}
