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

    temporaries:

    lxi: int - initial layout calc x
    lyi: int - initial layout calc y
    lx: int - current layout calc x
    ly: int - current layout calc y
    lh: int - current layout line height
*/

var ui; ui=dsmap()

dsmap(ui,"type",argument[0])
dsmap(ui,"enabled",true)
dsmap(ui,"state","up")

dsmap(ui,"parent",noone)
dsmap(ui,"children",dslist())
if (argument_count>1) dsmap(ui,"handler",argument[1]) else dsmap(ui,"handler",noone)

dsmap(ui,"style",noone)
dsmap(ui,"text","")
dsmap(ui,"alt","")
dsmap(ui,"help","")

dsmap(ui,"x",0)
dsmap(ui,"y",0)
dsmap(ui,"width",0)
dsmap(ui,"height",0)

dsmap(ui,"align",ui_left+ui_top)
dsmap(ui,"overflow",ui_over_spill)

return ui
