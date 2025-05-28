if (!instance_exists(argument0)) return false

with (argument0) {
    //reset to defaults
    if (setwidth==ui_fit_contents) width=0 else width=setwidth
    if (setheight==ui_fit_contents) height=0 else height=setheight

    if (parent==noone) {
        if (argument1!=ui_default) x=argument1
        if (argument2!=ui_default) y=argument2
        if (argument3!=ui_default) image_angle=argument3
        if (argument4!=ui_default) image_xscale=argument4
        if (argument5!=ui_default) image_yscale=argument5
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


    //for fill, we use the remaining space in the parent's box
    if (setwidth==ui_fill_space) width=parent.width-(x-parent.x)-parent.margin
    if (setheight==ui_fill_space) height=parent.height-(y-parent.y)-parent.margin

    
    //update children recursively
    var i;i=0 repeat (ds_list_size(children)) {
        if (!__gm82ui_layout_engine(ds_list_find_value(children,i),argument1,argument2,argument3,argument4,argument5)) exit
    i+=1}


    //for fitcontents, we resize to fit the contents
    if (setwidth==ui_fit_contents) width=max(width,lx+lph+margin-x)
    if (setheight==ui_fit_contents) height=max(height,ly+lh+lp+margin-y)


    //layout resolver
    mirror_h=false
    mirror_v=false
    if (parent!=noone) {
        if (parent.direction1==ui_left or parent.direction1==ui_right) {
            parent.lh=max(parent.lh,height+max(padding,parent.lpv))            
        }
        if (parent.direction1==ui_up or parent.direction1==ui_down) {
            parent.lh=max(parent.lh,width+max(padding,parent.lpv))            
        }
        parent.lp=max(parent.lp,padding)
        if (type==ui_t_break) {
            //break a line
            if (parent.direction1==ui_left or parent.direction1==ui_right) {
                parent.lx=parent.lxi
                parent.ly+=parent.lh
                parent.lh=0
                parent.lpv=parent.lp
                parent.lp=0
            }
            if (parent.direction1==ui_up or parent.direction1==ui_down) {
                parent.ly=parent.lyi
                parent.lx+=parent.lh
                parent.lh=0
                parent.lpv=parent.lp
                parent.lp=0
            }
        } else {
            //add to line
            if (parent.direction1==ui_left or parent.direction1==ui_right) {
                parent.lx+=width+max(padding,parent.lp)
                parent.lph=padding
    
                if (parent.direction1==ui_left) mirror_h=true
                if (parent.direction2==ui_up) mirror_v=true
            }
            
            if (parent.direction1==ui_up or parent.direction1==ui_down) {
                parent.ly+=height+max(padding,parent.lp)
                parent.lph=padding
            
                if (parent.direction1==ui_up) mirror_v=true
                if (parent.direction2==ui_left) mirror_h=true
            }
            
            if (mirror_h or mirror_v) __gm82ui_move(self,((parent.x+parent.width)-(x+width)-(x-parent.x))*mirror_h,((parent.y+parent.height)-(y+height)-(y-parent.y))*mirror_v)
        }
    } 
    
    if (direction1==ui_left or direction1==ui_right) {
        if (direction1==ui_left) mirror_h=true
        if (direction2==ui_up) mirror_v=true
    }
    
    if (direction1==ui_up or direction1==ui_down) {
        if (direction1==ui_up) mirror_v=true
        if (direction2==ui_left) mirror_h=true
    }
    
    var dx,dy;
    dx=0 dy=0
    if (setwidth==ui_fit_contents and mirror_h) dx=width
    if (setheight==ui_fit_contents and mirror_v) dy=height
    
    if (dx!=0 or dy!=0) {
        var i;i=0 repeat (ds_list_size(children)) {
            __gm82ui_move(ds_list_find_value(children,i),dx,dy)
        i+=1}
    }
}

return instance_exists(argument0)
