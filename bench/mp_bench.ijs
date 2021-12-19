NB. benchmark j vs af matmul performance

mp=: +/ . *

NB. arg is matrix row length
mptime=: 3 : 0
release_jaf_ AFS_jaf_ NB. release af arrays
af_device_gc_jaf_''   NB. af defice garbage collection

ja=: (y,y)$0.3+?17$5000
jb=: (y,y)$0.7+?17$5000
r=.   timex'jr=: ja mp jb'
r=. r,timex'afa=: af_create_array_jaf_ ja'
r=. r,timex'afb=: af_create_array_jaf_ jb'
r=. r,timex'afp=:af_matmul_jaf_ afa;afb;AF_MAT_TRANS_jaf_;AF_MAT_TRANS_jaf_'
r=. r,timex'af_sync_jaf_ _1'
r=. r,timex'afr=: get_jaf_ afp'
assert jr-:|:afr
h=.    <;._2'mp acreate bcreate matmul sync get aftot mp%aftot '
aftot=. +/}.r
h,.<"0 (<.1000*r,aftot),({.r)%aftot
)

