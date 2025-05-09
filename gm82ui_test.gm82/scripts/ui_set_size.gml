///ui_set_size(element,width,height,margin,[minwidth,minheight,maxwidth,maxheight])

dsmap(argument[0],"width",argument[1])
dsmap(argument[0],"height",argument[2])
dsmap(argument[0],"margin",argument[3])

if (argument_count==8) {
    dsmap(argument[0],"minwidth",argument[4])
    dsmap(argument[0],"minheight",argument[5])
    dsmap(argument[0],"maxwidth",argument[6])
    dsmap(argument[0],"maxheight",argument[7])
}
