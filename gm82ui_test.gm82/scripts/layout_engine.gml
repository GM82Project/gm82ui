if (!instance_exists(argument0)) return false

with (argument0) {
    //reset to defaults
    if (parent==noone) {
        //master
        if (argument1!=ui_preserve) x=argument1
        if (argument2!=ui_preserve) y=argument2
        if (argument3!=ui_preserve) image_angle=argument3
        if (argument4!=ui_preserve) image_xscale=argument4
        if (argument5!=ui_preserve) image_yscale=argument5
    } else {
        x=parent.lx+padding
        y=parent.ly+padding
    }

    lxi=x+margin
    lyi=y+margin
    lx=lxi
    ly=lyi
    lh=0 //line height
    lp=0 //line pad
    lph=0 //last pad hor
    lpv=0 //last pad vert

    if (setwidth==ui_fit_contents) width=0 else width=setwidth
    if (setheight==ui_fit_contents) height=0 else height=setheight


    //for fill, we use the remaining space in the parent's box
    if (setwidth==ui_fill_space) width=parent.width-(x-parent.x)

    
    //update children recursively
    var i;i=0 repeat (ds_list_size(children)) {
        if (!layout_engine(ds_list_find_value(children,i),argument1,argument2,argument3,argument4,argument5)) exit
    i+=1}


    //for fitcontents, we resize to fit the contents
    if (setwidth==ui_fit_contents) width=max(width,lx+lph+margin-x)
    if (setheight==ui_fit_contents) height=max(height,ly+lh+lp+margin-y)


    //layout resolver
    if (parent!=noone) {
        if (parent.direction1==ui_right) {
            parent.lh=max(parent.lh,height+max(padding,parent.lpv))            
        }
        if (parent.direction1==ui_down) {
            parent.lh=max(parent.lh,width+max(padding,parent.lpv))            
        }
        parent.lp=max(parent.lp,padding)
        if (type==ui_t_break) {
            //break a line
            if (parent.direction1==ui_right) {
                parent.lx=parent.lxi
                parent.ly+=parent.lh
                parent.lh=0
                parent.lpv=parent.lp
                parent.lp=0
            }
            if (parent.direction1==ui_down) {
                parent.ly=parent.lyi
                parent.lx+=parent.lh
                parent.lh=0
                parent.lpv=parent.lp
                parent.lp=0
            }
        } else {
            //add to line
            if (parent.direction1==ui_right) {
                parent.lx+=width+max(padding,parent.lp)
                parent.lph=padding
            }
            if (parent.direction1==ui_down) {
                parent.ly+=height+max(padding,parent.lp)
                parent.lph=padding
            }
        }
    } 
}

return instance_exists(argument0)
