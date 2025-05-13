///ui_create(type,[handler])
/*
    fields:

    type: const
    name: value
    enabled: bool
    state: string
    focus: bool

    parent: instance
    children: dslist

    handler: script
    style: script
    text: string
    alt: string
    help: string

    x: int
    y: int
    width: int
    height: int
    minwidth: int
    minheight: int
    maxwidth: int
    maxheight: int
    margin: int

    align: const mask
    resizable: const mask
    overflow: const
    direction: const

    //element-specific features
    window_title_side: const
    window_title_size: int
    button_sprite: sprite
*/

var ui; ui=instance_create(0,0,global.__ui_obj)

ui.type=argument[0]
ui.name=undefined
ui.enabled=true
ui.state="none"
ui.focus=0

ui.parent=noone
ui.children=ds_list_create()
if (argument_count>1) ui.handler=argument[1] else ui.handler=noone

ui.style=noone
ui.text=""
ui.alt=""
ui.help=""
ui.x=0
ui.y=0
ui.setwidth=0
ui.setheight=0
ui.width=0
ui.height=0
ui.margin=0
ui.padding=0

ui.align=ui_left+ui_up
ui.overflow=ui_over_spill
ui.direction=ui_right

ui.color=global.ui_col_main

ui.button_sprite=noone
ui.button_frame=0

instance_deactivate_object(ui)

return ui
