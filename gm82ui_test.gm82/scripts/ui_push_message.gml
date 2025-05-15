///ui_push_message(message,[data])
var l,i;

l=ds_list_create()

i=1 repeat (argument_count-1) {
    ds_list_add(l,argument[i])
i+=1}

ds_map_add(global.__ui_messages,argument[0],l)
