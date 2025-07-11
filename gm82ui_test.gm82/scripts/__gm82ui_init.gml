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
