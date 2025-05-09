var ui;ui=argument0

if (!dsmap(ui,"enabled")) exit

style=dsmap(ui,"style")
if (script_exists(style)) script_execute(style,ui)

children=dsmap(ui,"children")
i=0 repeat (ds_list_size(children)) {
    ui_draw(ds_list_find_value(children,i))
i+=1}
