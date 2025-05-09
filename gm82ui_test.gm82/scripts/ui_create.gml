///ui_create(type,[handler])
/*
    fields:

    type: const
    enabled: bool
    state: string

    parent: dsmap
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

    temporaries:

    lxi: int - initial layout calc x
    lyi: int - initial layout calc y
    lx: int - current layout calc x
    ly: int - current layout calc y
    lh: int - current layout line height
*/

var ui; ui=instance_create(0,0,global.__ui_obj)

ui.type=argument[0]
ui.enabled=true
ui.state="up"

ui.parent=noone
ui.children=ds_list_create()
if (argument_count>1) ui.handler=argument[1] else ui.handler=noone

ui.style=noone
ui.text=""
ui.alt=""
ui.help=""
ui.x=0
ui.y=0
ui.width=0
ui.height=0
ui.margin=0
ui.padding=0

ui.align=ui_left+ui_up
ui.overflow=ui_over_spill
ui.direction=ui_right

ui.lxi=0
ui.lyi=0
ui.lx=0
ui.ly=0
ui.lh=0
ui.lph=0
ui.lpv=0

instance_deactivate_object(ui)

return ui
