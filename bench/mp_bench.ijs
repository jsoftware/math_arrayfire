NB. benchmark j vs af matmul performance

mp=: +/ . *

0 : 0
   f32_jaf_ mptime 10000 NB. 32bit float time matric product 10000*10000
   f64_jaf_ mptime 10000 NB. 64bit float time matric product 10000*10000
   
matmul time will be 0 as it just starts the op
synh   time is the time to do the op

low end nvidia cards (gtx series) have fast f32 (32bit float), but 
 very slow f64 (64bit float), so f64 mp timings will not be much better than J

high end nvidia cards will have fast f64 and should be quite a bit faster than J
)

mptime=: 4 : 0
freeall_jaf_''
ja=: (y,y)$0.3+?17$5000
jb=: (y,y)$0.7+?17$5000
r=.   timex'jr=: ja mp jb'
r=. r,timex'afa=: x af_create_array_jaf_ ja'
r=. r,timex'afb=: x af_create_array_jaf_ jb'
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
