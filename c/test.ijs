testex=: 3 : 0
'j903-user/temp/arrayfire/c/libxafcpu.so testex x x'cd y
)

dt=: 3 : 0
memr 0 _1,~1{::'j903-user/temp/arrayfire/c/libxafcpu.so xaf_datetime x *'cd <,_1
)
