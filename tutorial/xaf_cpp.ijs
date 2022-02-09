0 : 0
you can add cpp routines to extend the arrayfire af_... routines
in some cases this can be easier in c/cpp than with the J binding to af_... routines
the cpp support for arrayfire has many nice fas that is the preferred arrayfire interface

this makes it easy to take an exisiting arrayfire routine written in c/cpp
and plug it into your J workflow

this tutorial shows a simple example of adding custom c/cpp routines
)

0 : 0
you need to build a shared library with your routines for your backend
e.g., libxafcpu.so is the shared libaray to use with the cpu backend

linux:
$ cd j903/addons/math/arrayfire/c
$ rm dll.o
$ make target=xaf backend=cpu -B -f dllmakefile # -B forces build of lib$(target)$(backend).sl

windows:
> cd j903\addons\math\arrayfire\c
> vcvars64.bat    - only do this once
> build.bat
)

3 : 0''
'backend not set by init'assert 0~:#backend_jaf_
select. UNAME
case. 'Win'    do. t=. 'afq.dll'
case. 'Linux'  do. t=. 'libxafq.so'
case. 'Darwin' do. t=. 'libxafq.dylib'
case.          do. 'host not supported'assert 0
end.
t=. t rplc 'q';backend_jaf_
libxaf_jaf_=: JAFP,'c/',t,' '
)

xafx_jaf_=: 4 : 0
r=. (libxaf,x)cd y
if. 0~:0{::r do. 'af cd call error result' assert 0 [LASTERROR=: (":0{::r),' ',(x{.~x i.' '),' ',af_err_to_string 0{::r end.
r
)

xaf_datetime_jaf_=: 3 : 0
memr 0 _1,~1{::'xaf_datetime x *'xafx <qresult
)

xaf_matmul_jaf_=: 3 : 0
afsadd 1{::'xaf_matmul x * x x'xafx aresult;vaf each y
)

xaf_randu_jaf_=: 3 : 0
afsadd 1{::'xaf_randu x * x'xafx aresult;y
)

xaf_gridxy_jaf_=: 3 : 0
afsadd 1{::'xaf_gridxy x * x'xafx aresult;y
)

0 : 0
cdf'' will unload the lib so that you can test with a new build
cdf'' can fail to unload for complicated reasons
use the following to check if you are using your latest build
)
xaf_datetime_jaf_'' NB. 

freeall_jaf_''

a1=: af_randu_jaf_ 4 4;f64_jaf_
a2=: af_randu_jaf_ 4 4;f64_jaf_
a3=: xaf_matmul_jaf_ a1,a2
get_jaf_ a3

a4=: xaf_randu_jaf_ 4
get_jaf_ a4

a5=: xaf_gridxy_jaf_ 3
get_jaf_ a5
