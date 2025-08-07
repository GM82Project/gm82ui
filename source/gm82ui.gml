#define __gm82ui_init
    global.__gm82ui_obj=object_add()
    global.__gm82ui_messages=ds_map_create()
    global.__gm82ui_alt=""
    global.__gm82ui_help=""
    global.__gm82ui_in_handler=false
    global.__gm82ui_mousefocus=true

    var dir,theme;

    dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
    theme=registry_read_dword(dir+"GM82CustomThemeIndex",0)

    if (theme==0) {
        global.__gm82ui_col_low=$203020
        global.__gm82ui_col_main=$404040
        global.__gm82ui_col_high=$607060
        global.__gm82ui_col_text=$ffffff
        global.__gm82ui_buttontex=sprButton0
    }
    if (theme==1) {
        global.__gm82ui_col_low=$808080
        global.__gm82ui_col_main=$c0c0c0
        global.__gm82ui_col_high=$ffffff
        global.__gm82ui_col_text=$000000
        global.__gm82ui_buttontex=sprButton1
    }

    if (theme==2) {
        global.__gm82ui_col_low=registry_read_dword(dir+"GM82CustomThemeColorLow",$203020)
        global.__gm82ui_col_main=registry_read_dword(dir+"GM82CustomThemeColorMain",$404040)
        global.__gm82ui_col_high=registry_read_dword(dir+"GM82CustomThemeColorHigh",$607060)
        global.__gm82ui_col_text=registry_read_dword(dir+"GM82CustomThemeColorText",$ffffff)
        global.__gm82ui_themebutton=median(0,registry_read_dword(dir+"GM82CustomThemeButtonType",1),2)
        a=sprButtonWhitemask
        if (global.__gm82ui_themebutton=1 || global.__gm82ui_themebutton=2) a=sprButtonWhitemaskSmooth
        s=surface_create(80,25)
        surface_set_target(s)
        draw_clear(global.__gm82ui_col_main)
        draw_sprite_ext(a,0,0,0,1,1,0,global.__gm82ui_col_high,1)
        draw_sprite_ext(a,1,0,0,1,1,0,global.__gm82ui_col_low,1)
        if (global.__gm82ui_themebutton=2) draw_rectangle_color(0,0,79,24,global.__gm82ui_col_text,global.__gm82ui_col_text,global.__gm82ui_col_text,global.__gm82ui_col_text,1)
        spr=sprite_create_from_surface(s,0,0,80,25,0,0,0,0)
        sprite_add_from_surface(spr,s,0,0,80,25,0,0)
        draw_clear(global.__gm82ui_col_main)
        draw_sprite_ext(a,0,0,0,1,1,0,global.__gm82ui_col_low,1)
        draw_sprite_ext(a,1,0,0,1,1,0,global.__gm82ui_col_high,1)
        if (global.__gm82ui_themebutton=2) draw_rectangle_color(0,0,79,24,global.__gm82ui_col_text,global.__gm82ui_col_text,global.__gm82ui_col_text,global.__gm82ui_col_text,1)
        sprite_add_from_surface(spr,s,0,0,80,25,0,0)
        surface_reset_target()
        surface_free(s)
        sprite_assign(sprButton,spr)
        global.__gm82ui_buttontex=sprButton
    }


#define __gm82ui_mark_stale
    var p;

    if (!global.__gm82ui_in_handler) instance_activate_object(global.__gm82ui_obj)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        exit
    }

    p=argument0
    while (p.parent) p=p.parent
    p.layout_stale=true

    if (!global.__gm82ui_in_handler) instance_deactivate_object(global.__gm82ui_obj)


#define __gm82ui_eat_message
    var l;

    if (ds_map_exists(global.__gm82ui_messages,argument0)) {
        l=ds_map_find_value(global.__gm82ui_messages,argument0)
        if (handler==noone) {
            ds_list_destroy(l)
            ds_map_delete(global.__gm82ui_messages,argument0)
            return 1
        } else {
            if (__gm82ui_fire_handler(argument0,l)) {
                ds_list_destroy(l)
                ds_map_delete(global.__gm82ui_messages,argument0)
                return 1
            }
        }
    }

    return 0


#define __gm82ui_fire_handler
    if (handler!=noone) {
        if (global.__gm82ui_in_handler) show_error("error in ui stack: handler recursion.",0)
        else {
            global.__gm82ui_in_handler=true
            if (handler==ui_default) ret=ui_default_handler(argument0,argument1)
            else ret=script_execute(handler,argument0,argument1)
            global.__gm82ui_in_handler=false
            return ret
        }
    }

    return false


#define __gm82ui_process_inner
    var i,mx,my,l;

    with (argument0) {
        //grab focus if nothing has focus
        var check;check=true
        with (global.__gm82ui_obj) if (keyfocus) {check=false}
        if (check and argument0.cantab) argument0.keyfocus=true

        //pre-update handler
        __gm82ui_fire_handler("step",noone)


        //reset to defaults
        focus=false
        if (parent==noone) {
            //top-level parent
            if (ds_map_exists(global.__gm82ui_messages,"mouse")) {
                l=ds_map_find_value(global.__gm82ui_messages,"mouse")

                mx=ds_list_find_value(l,0)
                my=ds_list_find_value(l,1)

                ds_list_destroy(l)
                ds_map_delete(global.__gm82ui_messages,"mouse")

                tmouse_x=x+pivot_pos_x(mx-x,my-y,-image_angle)/image_xscale
                tmouse_y=y+pivot_pos_y(mx-x,my-y,-image_angle)/image_yscale
            }
        } else {
            //child
            tmouse_x=parent.tmouse_x
            tmouse_y=parent.tmouse_y
        }


        //update children recursively
        i=0 repeat (ds_list_size(children)) {
            __gm82ui_process_inner(ds_list_find_value(children,i))
        i+=1}


        //handle events
        if (enabled) {
            //mouse collision
            if (point_in_rectangle(tmouse_x,tmouse_y,x,y,x+width,y+height)) {
                //focus
                if (ds_map_exists(global.__gm82ui_messages,"focus")) {
                    ds_list_destroy(ds_map_find_value(global.__gm82ui_messages,"focus"))
                    ds_map_delete(global.__gm82ui_messages,"focus")
                    focus=true
                    if (cantab) __gm82ui_takeyfocus()
                }

                if (handler!=noone) {
                    __gm82ui_eat_message("left click")
                    __gm82ui_eat_message("left release")
                    __gm82ui_eat_message("right click")
                    __gm82ui_eat_message("right release")
                    __gm82ui_eat_message("scroll up")
                    __gm82ui_eat_message("scroll down")
                }
            }

            if (keyfocus) {
                __gm82ui_eat_message("accept")
                __gm82ui_eat_message("accept press")
                __gm82ui_eat_message("accept release")
                __gm82ui_eat_message("cancel")
                __gm82ui_eat_message("cancel press")
                __gm82ui_eat_message("cancel release")
                __gm82ui_eat_message("menu")
                __gm82ui_eat_message("menu press")
                __gm82ui_eat_message("menu release")

                var tab;tab=__gm82ui_delete_message("tab")-__gm82ui_delete_message("back tab")
                if (tab!=0) {
                    var newtab,find; newtab=taborder
                    initial=id find=id
                    do {
                        newtab=modwrap(newtab+tab,0,topowner.tabcount)
                        with (global.__gm82ui_obj) if (topowner==other.topowner && taborder==newtab) {
                            __gm82ui_takeyfocus()
                            find=id
                            break
                        }
                    } until (find.cantab==true and find!=id) or (find==initial)
                }
            }
        }

        __gm82ui_fire_handler("end step",noone)
    }


#define __gm82ui_layout_engine
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


#define __gm82ui_draw_inner
    with (argument0) {
        if (type!=ui_t_break) {
            if (style==ui_default) __gm82ui_default_styler(self)
            else if (style!=noone) script_execute(style,self)

            if (focus) {
                global.__gm82ui_alt=alt
                global.__gm82ui_help=help
            }

            var i;i=0 repeat (ds_list_size(children)) {
                __gm82ui_draw_inner(ds_list_find_value(children,i))
            i+=1}

            if (keyboard_check(vk_f8)) {
                draw_rectangle(x,y,x+width,y+height,1)
                if (direction1==ui_right) {x1=x+8 x2=x+width-8}
                if (direction1==ui_left) {x1=x+width-8 x2=x+8}
                if (direction2=ui_down) {y1=y+8 y2=y+height-8}
                if (direction2=ui_up) {y1=y+height-8 y2=y+8}

                draw_arrow(x1,y1,x2,y1,7)
                draw_arrow(x2,y1,x2,y2,7)
            }
        }
    }


#define __gm82ui_destroy_inner
    instance_activate_object(argument0)

    with (argument0) {
        var i;i=0 repeat (ds_list_size(children)) {
            __gm82ui_destroy_inner(ds_list_find_value(children,i))
        i+=1}

        ds_list_destroy(children)
        instance_destroy()
    }


#define __gm82ui_default_styler
    //styler(element,[data])

    with (argument0) {
        draw_set_valign(1)
        draw_set_color(global.__gm82ui_col_text)
        draw_set_font(font0)

        if (type==ui_t_label) {
            draw_text(x,y+height div 2-1,text)
        } else if (type==ui_t_radio) or (type==ui_t_check) {
            down=2*(state=="checked")

            draw_sprite_part(global.__gm82ui_buttontex,2,0,0,4,4,x,y)
            draw_sprite_part(global.__gm82ui_buttontex,2,76,0,4,4,x+height-4,y)
            draw_sprite_part(global.__gm82ui_buttontex,2,0,21,4,4,x,y+height-4)
            draw_sprite_part(global.__gm82ui_buttontex,2,76,21,4,4,x+height-4,y+height-4)

            draw_sprite_part_ext(global.__gm82ui_buttontex,2,5,0,70,4,x+4,y,(height-8)/70,1,$ffffff,1)
            draw_sprite_part_ext(global.__gm82ui_buttontex,2,5,21,70,4,x+4,y+height-4,(height-8)/70,1,$ffffff,1)
            draw_sprite_part_ext(global.__gm82ui_buttontex,2,0,5,4,15,x,y+4,1,(height-8)/15,$ffffff,1)
            draw_sprite_part_ext(global.__gm82ui_buttontex,2,76,5,4,15,x+height-4,y+4,1,(height-8)/15,$ffffff,1)

            if (down) draw_sprite(sprIcons,1+(type==ui_t_radio),x+height div 2,y+height div 2)
            draw_text(x+height+4,y+height div 2-1,text)
        } else {
            down=2*(state!="up")

            if (type==ui_t_panel) down=0

            if (image_blend!=noone) {
                draw_rect(x,y,width,height,image_blend)
            }

            draw_sprite_part(global.__gm82ui_buttontex,down,0,0,4,4,x,y)
            draw_sprite_part(global.__gm82ui_buttontex,down,76,0,4,4,x+width-4,y)
            draw_sprite_part(global.__gm82ui_buttontex,down,0,21,4,4,x,y+height-4)
            draw_sprite_part(global.__gm82ui_buttontex,down,76,21,4,4,x+width-4,y+height-4)

            draw_sprite_part_ext(global.__gm82ui_buttontex,down,5,0,70,4,x+4,y,(width-8)/70,1,$ffffff,1)
            draw_sprite_part_ext(global.__gm82ui_buttontex,down,5,21,70,4,x+4,y+height-4,(width-8)/70,1,$ffffff,1)
            draw_sprite_part_ext(global.__gm82ui_buttontex,down,0,5,4,15,x,y+4,1,(height-8)/15,$ffffff,1)
            draw_sprite_part_ext(global.__gm82ui_buttontex,down,76,5,4,15,x+width-4,y+4,1,(height-8)/15,$ffffff,1)

            draw_set_halign(1)
            if (type==ui_t_button) {
                if (button_sprite!=noone) {
                    if (text!="") {
                        var sprw;sprw=sprite_get_width(button_sprite)
                        draw_sprite(button_sprite,button_frame,x+6+sprw div 2+down,y+height div 2+down)
                        draw_text(x+(width+sprw+3) div 2,y+height div 2-1,text)
                    } else draw_sprite(button_sprite,button_frame,x+width div 2+down,y+height div 2+down)
                } else draw_text(x+width div 2,y+height div 2-1,text)
            } else draw_text(x+width div 2,y+height div 2-1,text)
            draw_set_halign(0)
        }

        draw_set_valign(0)
        draw_set_color($ffffff)

        if (keyfocus) draw_rectangle(x-1,y-1,x+width,y+height,1)
    }


#define __gm82ui_move
    //(ui,dx,dy)

    with (argument0) {
        x+=argument1
        y+=argument2
        //layout_stale=true

        var i;i=0 repeat (ds_list_size(children)) {
            __gm82ui_move(ds_list_find_value(children,i),argument1,argument2)
        i+=1}
    }


#define __gm82ui_delete_message
    if (ds_map_exists(global.__gm82ui_messages,argument0)) {
        ds_list_destroy(ds_map_find_value(global.__gm82ui_messages,argument0))
        ds_map_delete(global.__gm82ui_messages,argument0)
        return 1
    }
    return 0


#define __gm82ui_takeyfocus
    with (global.__gm82ui_obj) keyfocus=false
    keyfocus=true


#define ui_create
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

        resizable: const mask 
        direction1: const
        direction2: const
    */

    if (argument[0]<0 or argument[0]>7) {
        show_error("in function ui_create: invalid type ("+string(argument[0])+")",0)
        exit
    }

    if (argument_count>1) {
        if (argument[1]!=ui_default) if (!script_exists(argument[1])) {
            show_error("in function ui_create: invalid handler ("+string(argument[1])+")",0)
            exit
        }
    }

    var ui; ui=instance_create(0,0,global.__gm82ui_obj)

    ui.type=argument[0]
    ui.name=undefined
    ui.enabled=true
    ui.state="none"
    ui.focus=false
    ui.dead=false

    ui.parent=noone
    ui.children=ds_list_create()
    if (argument_count>1) ui.handler=argument[1] else ui.handler=ui_default

    ui.cantab=false
    ui.topowner=ui
    ui.tabcount=0
    ui.taborder=noone
    ui.keyfocus=false

    ui.style=ui_default
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

    ui.resizable=ui_no         
    ui.direction1=ui_right
    ui.direction2=ui_down

    ui.image_blend=global.__gm82ui_col_main

    ui.layout_stale=false

    if (!global.__gm82ui_in_handler) instance_deactivate_object(ui)

    return ui


#define ui_set_enabled
    ///ui_set_enabled(element,enabled)

    ui_set_variable(argument0,"enabled",argument1)


#define ui_set_keyboard_enabled
    ///ui_set_keyboard_enabled(element,enabled)
    //enables the use of keyboard focus and controls for this element
    //disabled by default

    ui_set_variable(argument0,"cantab",argument1)


#define ui_set_name
    ///ui_set_name(element,name)

    ui_set_variable(argument0,"name",argument1)


#define ui_set_size
    ///ui_set_size(element,width,height,[margin,padding])

    if (argument_count<3) {
        show_error("in function ui_set_size: wrong number of arguments",0)
        exit
    }

    if (!global.__gm82ui_in_handler) instance_activate_object(argument[0])

    if (!instance_exists(argument0)) exit

    if (argument[0].object_index!=global.__gm82ui_obj) {
        show_error("in function ui_set_size: instance is "+object_get_name(argument[0].object_index)+" instead of an ui element",0)
        exit
    }

    if (argument[1]!=ui_default) argument[0].setwidth=argument[1]
    if (argument[2]!=ui_default) argument[0].setheight=argument[2]
    if (argument_count==5) {
        if (argument[3]!=ui_default) argument[0].margin=argument[3]
        if (argument[4]!=ui_default) argument[0].padding=argument[4]
    }

    if (!global.__gm82ui_in_handler) instance_deactivate_object(argument[0])


#define ui_set_constraints
    ///ui_set_constraints(element,minwidth,minheight,maxwidth,maxheight)

    if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_set_constraints: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    argument0.minwidth=argument1
    argument0.minheight=argument2
    argument0.maxwidth=argument3
    argument0.maxheight=argument4

    if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)


#define ui_set_format
    ///ui_set_format(element,resize,direction1,direction2)

    if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_set_format: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    argument0.resizable=argument1 
    argument0.direction1=argument2
    argument0.direction2=argument3

    if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)


#define ui_set_pos
    ///ui_set_pos(element,x,y)

    if (!global.__gm82ui_in_handler) instance_activate_object(global.__gm82ui_obj)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_set_pos: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    __gm82ui_move(argument0,argument1-argument0.x,argument2-argument0.y)

    if (!global.__gm82ui_in_handler) instance_deactivate_object(global.__gm82ui_obj)


#define ui_set_transform
    ///ui_set_transform(ui,rotation,xscale,yscale)

    if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_set_layout: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    __gm82ui_layout_engine(argument0,ui_default,ui_default,argument1,argument2,argument3)

    if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)


#define ui_set_style
    ///ui_set_style(element,style)

    ui_set_variable(argument0,"style",argument1)


#define ui_set_text
    ///ui_set_text(element,string)

    ui_set_variable(argument0,"text",argument1)


#define ui_set_alt
    ///ui_set_alt(element,alt,help)

    if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_set_alt: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    argument0.alt=argument1
    argument0.help=argument2

    if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)


#define ui_set_blend
    ///ui_set_blend(element,color,alpha)

    if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_set_blend: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    argument0.image_blend=argument1
    argument0.image_alpha=argument2

    if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)


#define ui_set_state
    ///ui_set_blend(element,state)

    ui_set_variable(argument0,"state",argument1)


#define ui_set_handler
    ///ui_set_handler(element,handler)

    ui_set_variable(argument0,"handler",argument1)


#define ui_set_variable
    ///ui_set_variable(element,variable,value)

    if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_set_[variable]: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    variable_instance_set(argument0,argument1,argument2)
    if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)


#define ui_get_variable
    ///ui_get_variable(element,variable)

    if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_get_[variable]: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    var ret;ret=variable_instance_get(argument0,argument1)
    if (!global.__gm82ui_in_handler) instance_deactivate_object(argument0)

    return ret


#define ui_get_help
    ///ui_get_help()
    //returns the help string of the currently focused element.

    return global.__gm82ui_help


#define ui_get_alt
    ///ui_get_alt()
    //returns the alt string of the currently focused element.

    return global.__gm82ui_alt


#define ui_get_by_name
    ///ui_get_by_name(name)

    if (!global.__gm82ui_in_handler) instance_activate_object(global.__gm82ui_obj)

    var find;find=noone
    with (global.__gm82ui_obj) {
        if (is_string(name)==is_string(argument0)) if (name==argument0) {find=id break}
    }

    if (!global.__gm82ui_in_handler) {
        instance_deactivate_object(global.__gm82ui_obj)
        instance_activate_object(find)
    }

    return find


#define ui_append_child
    ///ui_append_child(element,child)

    var element;element=argument1
    if (element<100000) element=ui_create(argument1)

    if (!global.__gm82ui_in_handler) {
        instance_activate_object(argument0)
        instance_activate_object(element)
    }

    if (!instance_exists(argument0)) exit
    if (!instance_exists(element)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_append_child: element is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }
    if (element.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_append_child: child is "+object_get_name(element.object_index)+" instead of an ui element",0)
        exit
    }

    element.parent=argument0
    ds_list_add(argument0.children,element)


    var top;top=argument0
    while (top.parent!=noone) {
        top=top.parent
        instance_activate_object(top)
    }
    element.taborder=top.tabcount
    top.tabcount+=1
    element.topowner=top


    if (!global.__gm82ui_in_handler) {
        instance_deactivate_object(global.__gm82ui_obj)
    }

    __gm82ui_mark_stale(element)

    return element


#define ui_orphan
    ///ui_orphan(element)

    if (!global.__gm82ui_in_handler) instance_activate_object(argument0)

    if (!instance_exists(argument0)) exit

    if (argument0.parent==noone) exit

    if (!global.__gm82ui_in_handler) instance_activate_object(argument0.parent)

    ds_list_delete(argument0.parent.children,ds_list_find_index(argument0.parent.children,argument0.id))
    argument0.parent=noone

    if (!global.__gm82ui_in_handler) {
        instance_deactivate_object(argument0.parent)
        instance_deactivate_object(argument0)
    }

    __gm82ui_mark_stale(element)


#define ui_destroy
    ///ui_destroy(element)

    ui_set_variable(argument0,"dead",true)
    __gm82ui_mark_stale(argument0)


#define ui_push_default_mouse
    ui_push_message("mouse",mouse_x,mouse_y)
    ui_push_message("focus")

    if (mouse_check_button(mb_left)) ui_push_message("left button")
    if (mouse_check_button_pressed(mb_left)) ui_push_message("left click")
    if (mouse_check_button_released(mb_left)) ui_push_message("left release")

    if (mouse_check_button(mb_right)) ui_push_message("right button")
    if (mouse_check_button_pressed(mb_right)) ui_push_message("right click")
    if (mouse_check_button_released(mb_right)) ui_push_message("right release")

    if (mouse_wheel_up()) ui_push_message("scroll up")
    if (mouse_wheel_down()) ui_push_message("scroll down")


#define ui_push_default_keyboard
    if (keyboard_check(vk_enter) or keyboard_check(vk_space)) ui_push_message("accept")
    if (keyboard_check_pressed(vk_enter) and not keyboard_check(vk_space)) or (keyboard_check_pressed(vk_space) and not keyboard_check(vk_enter)) ui_push_message("accept press")
    if (keyboard_check_released(vk_enter) and not keyboard_check(vk_space)) or (keyboard_check_released(vk_space) and not keyboard_check(vk_enter)) ui_push_message("accept release")

    if (keyboard_check(vk_escape)) ui_push_message("cancel")
    if (keyboard_check_pressed(vk_escape)) ui_push_message("cancel press")
    if (keyboard_check_released(vk_escape)) ui_push_message("cancel release")

    if (keyboard_check(vk_menu)) ui_push_message("menu")
    if (keyboard_check_pressed(vk_menu)) ui_push_message("menu press")
    if (keyboard_check_released(vk_menu)) ui_push_message("menu release")

    if (keyboard_check_pressed(vk_pageup)) ui_push_message("page up")
    if (keyboard_check_pressed(vk_pagedown)) ui_push_message("page down")

    if (keyboard_check_pressed(vk_tab)) {
        if (keyboard_check(vk_shift)) ui_push_message("back tab") else ui_push_message("tab")
    }


#define ui_push_default_messages
    ui_push_default_mouse()
    ui_push_default_keyboard()


#define ui_push_message
    ///ui_push_message(message,[data])

    var l;l=ds_list_create()

    var i;i=1 repeat (argument_count-1) {
        ds_list_add(l,argument[i])
    i+=1}

    ds_map_add(global.__gm82ui_messages,argument[0],l)


#define ui_has_message
    ///ui_has_message(message)

    return ds_map_exists(global.__gm82ui_messages,argument0)


#define ui_process_messages
    ///ui_process_messages(element)

    instance_activate_object(global.__gm82ui_obj)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_process_messages: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    __gm82ui_process_inner(argument0)

    //handle death
    with (global.__gm82ui_obj) if (dead) {
        __gm82ui_fire_handler("destroy",noone)
        ui_orphan(self)
        __gm82ui_destroy_inner(self)
    }

    instance_deactivate_object(global.__gm82ui_obj)

    //clear all messages
    var key;key=ds_map_find_first(global.__gm82ui_messages) repeat (ds_map_size(global.__gm82ui_messages)) {
        ds_list_destroy(ds_map_find_value(global.__gm82ui_messages,key))
    key=ds_map_find_next(global.__gm82ui_messages,key)}
    ds_map_clear(global.__gm82ui_messages)


#define ui_draw
    ///ui_draw(ui)

    global.__gm82ui_alt=""
    global.__gm82ui_help=""

    instance_activate_object(global.__gm82ui_obj)

    if (!instance_exists(argument0)) exit

    if (argument0.object_index!=global.__gm82ui_obj) {
        show_error("in function ui_draw: instance is "+object_get_name(argument0.object_index)+" instead of an ui element",0)
        exit
    }

    with (argument0) {
        if (layout_stale) ui_set_transform(self,ui_default,ui_default,ui_default)
        d3d_transform_stack_push()
        d3d_transform_add_translation(-x,-y,0)
        d3d_transform_add_scaling(image_xscale,image_yscale,1)
        d3d_transform_add_rotation_z(image_angle)
        d3d_transform_add_translation(x,y,0)
        __gm82ui_draw_inner(self)
        d3d_transform_stack_pop()
    }

    instance_deactivate_object(global.__gm82ui_obj)


#define ui_draw_default_tooltip
    ///ui_draw_default_tooltip(x,y)
    var w,h,dx,dy;

    if (global.__gm82ui_alt!="") {
        w=string_width(global.__gm82ui_alt)+8
        h=24

        dx=argument0
        dy=argument1

        draw_rectangle_color(dx,dy,dx+w,dy+h,$c0ffff,$c0ffff,$c0ffff,$c0ffff,0)
        draw_rectangle_color(dx,dy,dx+w,dy+h,0,0,0,0,1)
        draw_set_valign(1)
        draw_set_color(0)
        draw_set_font(font0)
        draw_text(dx+4,dy+12-1,global.__gm82ui_alt)
        draw_set_valign(0)
        draw_set_color($ffffff)
    }


#define ui_default_handler
    var data;data=argument1

    switch (type) {
        case ui_t_radio: {
            switch (argument0) {
                case "left click": case "accept press": {
                    with (global.__gm82ui_obj) if (type==ui_t_radio) and (parent==other.parent) {
                        state="none"
                    }
                    state="checked"
                    return true
                }break
            }
        }break
        case ui_t_check: {
            switch (argument0) {
                case "left click": case "accept press": {
                    if (state=="checked") state="none"
                    else state="checked"
                    return true
                }break
            }
        }break
    }

    return false


#define ui_settings
    ///ui_settings(setting,value)

    switch (argument0) {
        case ui_set_mousefocus: global.__gm82ui_mousefocus=!!argument1
    }
//
//