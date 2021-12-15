NB. benchmark j vs af performance

mp_bench=: 3 : 0
ja=: 10000 10000$0.3+?17$5000
jb=: 10000 10000$0.7+?17$5000
jtime=: timex'q=: ja mp_jaf_ jb' 

afa=: af_create_array_jaf_ ja NB. create arrayfire array
afb=: af_create_array_jaf_ jb
NB. afa/afb - int scalar handles to data in af device space

NB. note args and result are transposed
aftime=: timex'qaf=: |:get_jaf_ af_matmul_jaf_ afa;afb;AF_MAT_TRANS_jaf_;AF_MAT_TRANS_jaf_'

assert q-:qaf

jtime,aftime
)