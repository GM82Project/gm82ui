#define __gm82ui_init
    global.__gm82ui_obj=object_add()
    global.__gm82ui_messages=ds_map_create()
    global.__gm82ui_alt=""
    global.__gm82ui_help=""
    global.__gm82ui_in_handler=false
    global.__gm82ui_mousefocus=true
    global.__gm82ui_theme_loaded=false
    
    var dir,theme;

    dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
    theme=registry_read_dword(dir+"GM82CustomThemeIndex",0)

    if (theme==0) {
        global.__gm82ui_col_low=$203020
        global.__gm82ui_col_main=$404040
        global.__gm82ui_col_high=$607060
        global.__gm82ui_col_text=$ffffff
    }
    if (theme==1) {
        global.__gm82ui_col_low=$808080
        global.__gm82ui_col_main=$c0c0c0
        global.__gm82ui_col_high=$ffffff
        global.__gm82ui_col_text=$000000
    }
    if (theme==2) {
        global.__gm82ui_col_low=registry_read_dword(dir+"GM82CustomThemeColorLow",$203020)
        global.__gm82ui_col_main=registry_read_dword(dir+"GM82CustomThemeColorMain",$404040)
        global.__gm82ui_col_high=registry_read_dword(dir+"GM82CustomThemeColorHigh",$607060)
        global.__gm82ui_col_text=registry_read_dword(dir+"GM82CustomThemeColorText",$ffffff)
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
            if (handler==ui_default) {
                if (type==ui_t_button) __gm82ui_button_handler(argument0,argument1)
                ret=ui_default_handler(argument0,argument1)
            } else ret=script_execute(handler,argument0,argument1)
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
            if (style==ui_default) ui_default_styler(self)
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


#define __gm82ui_default_theme_loader
    if (!global.__gm82ui_theme_loaded) {
        var dir,theme;

        dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
        theme=registry_read_dword(dir+"GM82CustomThemeIndex",0)

        if (theme==0) {
            global.__gm82ui_col_low=$203020
            global.__gm82ui_col_main=$404040
            global.__gm82ui_col_high=$607060
            global.__gm82ui_col_text=$ffffff
            global.__gm82ui_buttontex=sprite_add_sprite(temp_directory+"\gm82\sprButton0.gmspr")
        }
        if (theme==1) {
            global.__gm82ui_col_low=$808080
            global.__gm82ui_col_main=$c0c0c0
            global.__gm82ui_col_high=$ffffff
            global.__gm82ui_col_text=$000000
            global.__gm82ui_buttontex=sprite_add_sprite(temp_directory+"\gm82\sprButton1.gmspr")
        }

        if (theme==2) {
            global.__gm82ui_col_low=registry_read_dword(dir+"GM82CustomThemeColorLow",$203020)
            global.__gm82ui_col_main=registry_read_dword(dir+"GM82CustomThemeColorMain",$404040)
            global.__gm82ui_col_high=registry_read_dword(dir+"GM82CustomThemeColorHigh",$607060)
            global.__gm82ui_col_text=registry_read_dword(dir+"GM82CustomThemeColorText",$ffffff)
            global.__gm82ui_themebutton=median(0,registry_read_dword(dir+"GM82CustomThemeButtonType",1),2)
            if (global.__gm82ui_themebutton=1 || global.__gm82ui_themebutton=2) a=sprite_add_sprite(temp_directory+"\gm82\sprButtonWhitemaskSmooth.gmspr")
            else a=sprite_add_sprite(temp_directory+"\gm82\sprButtonWhitemask.gmspr")
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
            global.__gm82ui_buttontex=spr
        }
        global.__gm82ui_font=font_add_file(temp_directory+"\gm82\JetBrainsMonoNL-Medium.ttf","JetBrains Mono NL Medium",12,0,0,0,255)
        global.__gm82ui_theme_loaded=true
    }
    draw_set_font(global.__gm82ui_font)
//
//