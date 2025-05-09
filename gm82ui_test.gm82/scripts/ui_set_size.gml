///ui_set_size(element,width,height,margin,padding,[minwidth,minheight,maxwidth,maxheight])

var ui;ui=argument[0]

instance_activate_object(ui)

ui.width=argument[1]
ui.height=argument[2]
ui.margin=argument[3]
ui.padding=argument[4]

if (argument_count==9) {
    ui.minwidth=argument[5]
    ui.minheight=argument[6]
    ui.maxwidth=argument[7]
    ui.maxheight=argument[8]
}

instance_deactivate_object(ui)
