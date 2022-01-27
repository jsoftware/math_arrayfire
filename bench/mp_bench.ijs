NB. benchmark j vs af matmul performance

mp=: +/ . *

NB. arg is matrix row length
NB. report time in milliseconds for each step
mptime=: 3 : 0
freeall_jaf_''
ja=: (y,y)$0.3+?17$5000
jb=: (y,y)$0.7+?17$5000
r=.   timex'jr=: ja mp jb'
r=. r,timex'afa=: af_create_array_jaf_ ja'
r=. r,timex'afb=: af_create_array_jaf_ jb'
r=. r,timex'afp=:af_matmul_jaf_ afa,afb'
r=. r,timex'af_sync_jaf_ _1'
r=. r,timex'afr=: get_jaf_ afp'

if. jr-:afr do.
 echo 'J and AF results match exactly'
else.
 echo 'J and AF results have max abs difference of: ',":>./,|jr-afr
end.
h=.    <;._2'mp acreate bcreate matmul sync get aftot mp%aftot '
aftot=. +/}.r
(' step';' millis'),h,.<"0 (<.1000*r,aftot),({.r)%aftot
)

