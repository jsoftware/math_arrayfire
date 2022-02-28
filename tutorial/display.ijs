0 : 0
display array on console or as text string in session
 for some reason these functions are the most flaky
 across os/cpu/video/backend
 sometimes the display is truncated very early
 and sometimes there is a crash
 
they would be useful tools if the problems can be sorted out 
) 
 
afad=. af_create_array_jaf_ jai=. 1.5+i.2 4
get_jaf_ afad
display_jaf_ afad 
af_print_array_jaf_ afad
t=.'no name',LF,'[2 4 1 1]',LF
assert t-:(#t){.display_jaf_ afad