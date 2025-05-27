global.__ui_obj=object_add()
global.__ui_messages=ds_map_create()
global.__ui_alt=""
global.__ui_help=""
global.__ui_in_handler=false

var dir,theme;

dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
theme=registry_read_dword(dir+"GM82CustomThemeIndex",0)

if (theme==0) {
    global.ui_col_low=$203020
    global.ui_col_main=$404040
    global.ui_col_high=$607060
    global.ui_col_text=$ffffff
    global.ui_buttontex=sprButton0
}
if (theme==1) {
    global.ui_col_low=$808080
    global.ui_col_main=$c0c0c0
    global.ui_col_high=$ffffff
    global.ui_col_text=$000000
    global.ui_buttontex=sprButton1
}

if (theme==2) {
    global.ui_col_low=registry_read_dword(dir+"GM82CustomThemeColorLow",$203020)
    global.ui_col_main=registry_read_dword(dir+"GM82CustomThemeColorMain",$404040)
    global.ui_col_high=registry_read_dword(dir+"GM82CustomThemeColorHigh",$607060)
    global.ui_col_text=registry_read_dword(dir+"GM82CustomThemeColorText",$ffffff)
    global.ui_themebutton=median(0,registry_read_dword(dir+"GM82CustomThemeButtonType",1),2)
    a=sprButtonWhitemask
    if (global.ui_themebutton=1 || global.ui_themebutton=2) a=sprButtonWhitemaskSmooth
    s=surface_create(80,25)
    surface_set_target(s)
    draw_clear(global.ui_col_main)
    draw_sprite_ext(a,0,0,0,1,1,0,global.ui_col_high,1)
    draw_sprite_ext(a,1,0,0,1,1,0,global.ui_col_low,1)
    if (global.ui_themebutton=2) draw_rectangle_color(0,0,79,24,global.ui_col_text,global.ui_col_text,global.ui_col_text,global.ui_col_text,1)
    spr=sprite_create_from_surface(s,0,0,80,25,0,0,0,0)
    sprite_add_from_surface(spr,s,0,0,80,25,0,0)
    draw_clear(global.ui_col_main)
    draw_sprite_ext(a,0,0,0,1,1,0,global.ui_col_low,1)
    draw_sprite_ext(a,1,0,0,1,1,0,global.ui_col_high,1)
    if (global.ui_themebutton=2) draw_rectangle_color(0,0,79,24,global.ui_col_text,global.ui_col_text,global.ui_col_text,global.ui_col_text,1)
    sprite_add_from_surface(spr,s,0,0,80,25,0,0)
    surface_reset_target()
    surface_free(s)
    sprite_assign(sprButton,spr)
    global.ui_buttontex=sprButton
}
