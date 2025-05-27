//(ui,dx,dy)

with (argument0) {
    x+=argument1
    y+=argument2
    //layout_stale=true

    var i;i=0 repeat (ds_list_size(children)) {
        __gm82ui_move(ds_list_find_value(children,i),argument1,argument2)
    i+=1}
}
