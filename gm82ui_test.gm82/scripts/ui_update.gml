///ui_update(element)
var ui,parent,children,i;

ui=argument0

if (!dsmap(ui,"enabled")) exit

parent=dsmap(ui,"parent")

if (parent==noone) {
    dsmap(ui,"x",0)
    dsmap(ui,"y",0)
} else {
    dsmap(ui,"x",dsmap(parent,"lx"))
    dsmap(ui,"y",dsmap(parent,"ly"))
}

dsmap(ui,"lxi",dsmap(ui,"x"))
dsmap(ui,"lyi",dsmap(ui,"y"))

dsmap(ui,"lx",dsmap(ui,"lxi",0))
dsmap(ui,"ly",dsmap(ui,"lyi",0))
dsmap(ui,"lh",0)

children=dsmap(ui,"children")
i=0 repeat (ds_list_size(children)) {
    ui_update(ds_list_find_value(children,i))
i+=1}

if (dsmap(ui,"overflow")==ui_over_fitcontents) {
    dsmap(ui,"width",dsmap(ui,"lx"))
}

if (parent!=noone) {
    dsmap(parent,"lh",max(dsmap(parent,"lh"),dsmap(ui,"height")+dsmap(ui,"margin")))
    if (dsmap(ui,"type")==ui_t_break) {
        dsmap(parent,"lx",dsmap(parent,"lxi"))
        dsmap(parent,"ly",dsmap(parent,"ly")+dsmap(ui,"lh"))
    } else {
        dsmap(parent,"lx",dsmap(parent,"lx")+dsmap(ui,"width"))
//        dsmap(parent,"ly",dsmap(parent,"ly")+dsmap(ui,"height"))
    }
}
