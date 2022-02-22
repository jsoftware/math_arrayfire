0 : 0
you can add cpp (c++) routines to extend the af_... routines

it is easy to take an existing arrayfire routine written in cpp
and plug it into your J workflow

this tutorial shows a simple example of using custom cpp routines
)

create_work_folder=: 3 : 0 NB. xaf shared lib created in temp work folder
mkdir_j_ '~temp/arrayfire/c'
fsrc=. 1 dir JAFP,'c'
fsnk=. (<'~temp/arrayfire/'),each(#JAFP)}.each fsrc
(fread each fsrc)fwrite each fsnk
i.0 0
)

3 : 0'' NB. create work folder if it does not already exist
if. 0=fexist'~temp/arrayfire/c/xaf.cpp' do. create_work_folder'' end.
)

jpath'~temp/arrayfire/c' NB. path to work folder

0 : 0
build shared library with arrayfire cpp routines
for example, build a shared library from xaf.cpp for cpu backend

linux:
$ cd path_to_workfolder
$ chmod +x build_linux.sh
$ ./build_linux.sh xaf cpu

macos:
% cd path_to_workfolder
$ chmod +x build_macos.sh
$ ./build_macos.sh xaf cpu

windows: (assumes you have visual studio 2019 installed)
> cd path_to_workfolder
> build.bat xaf cpu
)

xaf_init=: 3 : 0
'backend not set by init'assert 0~:#backend_jaf_
select. UNAME
case. 'Win'    do. t=. 'xafq.dll'
case. 'Linux'  do. t=. 'libxafq.so'
case. 'Darwin' do. t=. 'libxafq.dylib'
case.          do. 'host not supported'assert 0
end.
t=. t rplc 'q';backend_jaf_
libxaf_jaf_=: jpath'~temp/arrayfire/c/',t,' '
)

xaf_init''

xafx_jaf_=: 4 : 0
r=. (libxaf,x)cd y
if. 0~:0{::r do. 'xaf cd call error result' assert 0 [LASTERROR=: (":0{::r),' ',(x{.~x i.' '),' ',af_err_to_string 0{::r end.
r
)

xaf_datetime_jaf_=: 3 : 0
memr 0 _1,~1{::'xaf_datetime x *'xafx <qresult
)

xaf_gridxy_jaf_=: 3 : 0
afsadd 1{::'xaf_gridxy x * x'xafx aresult;y
)

xaf_matmul_jaf_=: 3 : 0
afsadd 1{::'xaf_matmul x * x x'xafx aresult;vaf each y
)

freeall_jaf_''

0 : 0
cdf'' will unload the lib so that you can test with a new build
cdf'' can fail to unload for complicated reasons
use the following to check if you are using your latest build
)

xaf_datetime_jaf_''

a5=: xaf_gridxy_jaf_ 3
get_jaf_ a5

a1=: af_randu_jaf_ 4 4;f64_jaf_
a2=: af_randu_jaf_ 4 4;f64_jaf_
a3=: xaf_matmul_jaf_ a1,a2
get_jaf_ a3

a2i=: af_randu_jaf_ 4 4;s64_jaf_ NB. different type to trigger exception
'assertion failure'-:xaf_matmul_jaf_ etx a1,a2i NB. error
13!:12''
LASTERROR_jaf_

freeall_jaf_''