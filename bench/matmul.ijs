NB. benchmark j vs af matmul performance

mp=: +/ . *

0 : 0
   f32_jaf_ mptime 1000 NB. 32bit float time matrix product 1000*1000
   f64_jaf_ mptime 1000 NB. 64bit float time matrix product
   mpx             1000 NB. 64bit and 32bit reports
                        NB. try with larger arrays - e.g., 10000   

acreate/bcreate/get rows - millis to move data between backend and cpu
matmul                   - start the backend op
sync                     - wait for backend op to complete
aftot                    - total time to do the mp in arrayfire
x/ . *                   - total time to do the mp in J

low end nvidia cards (gtx series) have fast f32 (32bit float), but 
 very slow f64 (64bit float), so f64 mp timings will not be much better than J

high end nvidia cards will have fast f64 and should be quite a bit faster than J
)

mptime=: 4 : 0
freeall_jaf_''
ja=: (y,y)$0.3+?17$5000
jb=: (y,y)$0.7+?17$5000
r=. ''
r=. r,timex'afa=: x af_create_array_jaf_ ja'
r=. r,timex'afb=: x af_create_array_jaf_ jb'
r=. r,timex'afp=:af_matmul_jaf_ afa,afb'
r=. r,timex'af_sync_jaf_ _1'
r=. r,timex'afr=: get_jaf_ afp'
r=. r,aftot=. +/r
r=. r,mptot=. timex'jr=: ja mp jb'

if. jr-:afr do.
 echo 'J and AF results match exactly'
else.
 echo 'J and AF results have max abs difference of: ',":>./,|jr-afr
end.
h=.  (<;._2'acreate bcreate matmul sync get aftot '),('x/ . *');<'J % aftot'
h,.<"0 (<.1000*r),mptot%aftot
)

mpx=: 3 : 0
a=. f64_jaf_ mptime y
b=. f32_jaf_ mptime y
h=. (":y);'f64';'f32'
h,a,.{:"1 b
)
