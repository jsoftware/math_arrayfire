0 : 0
a few common things are wrapped for easy use
 and examples are given here

q verbs are defined in qcommon.ijs and are loaded with arrayfire
)

mp=: +/ . *

NB. define J data for tests
setdata=: 3 : 0
ja__=: y$0.3+?17$5000
jb__=: (|.y)$0.7+?17$5000
i.0 0
)

setdata 5 5

ja mp       jb
ja qmp_jaf_ jb

>./,|(ja mp jb)-ja qmp_jaf_ jb NB. close, but not the same

dotime=: 3 : 0
a=. timex 'ja mp           jb'
b=. timex 'ja qmp_jaf_     jb'         NB. f64 on device
c=. timex 'ja qmp_f32_jaf_ jb'         NB. f32 on device
h=. <;._2'mp qmp qmp_f32 mp%qmp qmp%f32 '
echo h,.<"0 (<.1000*a,b,c),a%b,c
a,b,c
)

setdata 1000 1000 NB.try larger values if device has enough mem - e.g. 10000
dotime''

NB. lower end nvidea cards have slow f64 and faster f32

NB. try with larger setdata args
