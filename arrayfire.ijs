NB. J arrayfire cd bindings

coclass'jaf'

man=: 0 : 0
J-ArrayFire cd bindings

if unfamiliar with arrayfire, browse: https://arrayfire.org
arrayfire install hints: fread JAFP,'install/install.txt'

arrayfire backend must be initialized before it can be used
 cpu    - always available and uses cpu memory and cores
 cuda   - available if you have suitable hardware and cuda software installed
 opencl - available if you have suitable hardware and opencl software installed

   init_jaf_'cpu' NB. 'cpu' or 'cuda' or 'opencl'

   man_test_jaf_  NB. labs, tests, examples, and benchmarks
   man_col_jaf_   NB. col vs row major order
   man_bugs_jaf_  NB. known bugs or problems

   JAFP_z_        NB. path to scripts - usually ~addons/math/arrayfire

util/util.ijs tools that create files from c headers
 families.ijs     - J cd  bindings for families of routines
 util/proto.txt   - all arrayfire c protypes
 util/famcnts.txt - count and 1st member of each family with same prototype

*** credits
Pascal Jasmin was the J-ArrayFire pioneer in 2015 with
 https://github.com/Pascal-J/Jfire
 
Alex Shroyer, in late 2021, did some new work and wrote a paper:
 https://alexshroyer.com/papers/matmul_j_gpu.pdf

this addon started with a clean slate - it might be interesting 
 to see if it could be improved/replaced by the work of Pascal or Alex
)

man_test=: 0 : 0
   test_jaf_''            NB. names
   test_jaf_'basic'       NB. script for basic
   loadd test_jaf_'basic' NB. loadd basic
   load"1 test_jaf_"1 test_jaf_'' NB. load all tests
   load JAFP,'bench/mp_bench.ijs'
   mptime 4000            NB. takes several seconds to run
   
JHS   
   spx test_jaf_'create'  NB. JHS - run basic with spx

Jqt
   load'labs/labs'
   lab test_jaf_ 'create' NB. run create test with lab
)

man_col=: 0 : 0
J array is row major - AF array is column major
 af_create_array creates an AF array with verb rcc
 get reads the array back with an rcc inverse

browse: https://arrayfire.org/docs/classaf_1_1array.htm
 and searchfor: {0, 1, 2, 3, 4, 5}
 to see how host data (raveled row major order) populates an AF array
 and to understand why rcc is necessary
)

man_bugs_=: 0 : 0
*** sparse
 display/af_print_array sparse array messes up ref counts
 workaround is to ignore those requests with:
   NO_SPARSE_DISPLAY=: 1
)

rcc=: 3 : '($y)$,|:y' NB. convert J data between row and col major

3 : 0''
NB. ensure different (production vs development) packages are not both loaded
n=. '/arrayfire.ijs'
d=. jpath each 4!:3''
f=. (;(<n)-:each (-#n){.each d)#d
'can not mix different arrayfire packages' assert 1=#f
f=. (-<:#n)}.;f
c=. #t=. jpath'~addons'
if. t-:c{.f do.
 t=. '~addons/',}.c}.f 
else.
 c=. #t=. jpath'~'
 if. t-:c{.f do. t=. }.c}.f end.
end.
JAFP_z_=: t
if. _1=nc<'lib' do.
 AFS=: '' NB. valid af_array values
 lib=: 'invalidlib'
 backend=: ''
end.
)

require JAFP,'families.ijs' NB. define verbs for mop/dop/is/...

NB. y is 'cpu' or 'cuda' or 'opencl'
NB. af_set_backend is implicit in the lib that is used
init=: 3 : 0
'invalid backend'assert (<y) e. ;:'cpu cuda opencl'
if. backend-:y do. i.0 0 return. end.

if. (UNAME-:'Linux')*.y-:'cpu' do.
 NB. check if required LD_PRELOAD has been done
 try.
  'libmkl_def.so foo x'cd''
 catch.
  if. 1 0-:cder'' do. 
   echo preload
   'required LD_PRELOAD missing'assert 0
  end.
 end. 
end.

select. UNAME
case. 'Linux' do.
 t=. 'libafxxx.so ' rplc 'xxx';y
 afincpath=: '/opt/arrayfire/include' NB. path to af includes
 
case. 'Win'   do.
 t=. 'afxxx.dll ' rplc 'xxx';y
 afincpath=: jpath (getenv'AF_PATH'),'/include' NB. path to af includes
case.         do. 'need to set lib'assert 0
end.
try. (t,'af_get_seed x *')cd <iresult catch. 'arrayfire lib load failed'assert 0 end.
lib=: t
backend=: y
NO_SPARSE_DISPLAY=: 1
i.0 0
)

test=: 3 : 0
require'labs/labs'
if. ''-:y do.
 d=. 1 dir JAFP,'test'
 >_4}.each(>:;d i: each '/')}.each d
 return.
end. 
f=. JAFP,'test/',(dltb y),'.ijs'
'test does not exist'assert fexist f
f
)

NB. af constants from array.h etc
'f32 c32 f64 c64 b8 s32 u32 u8 s64 u64 s16 u16 f16'=: i.13 NB. af array types

AF_MAT_NONE       =: 0    
AF_MAT_TRANS      =: 1    
AF_MAT_CTRANS     =: 2    
AF_MAT_CONJ       =: 4    
AF_MAT_UPPER      =: 32   
AF_MAT_LOWER      =: 64   
AF_MAT_DIAG_UNIT  =: 128  
AF_MAT_SYM        =: 512  
AF_MAT_POSDEF     =: 1024 
AF_MAT_ORTHOG     =: 2048 
AF_MAT_TRI_DIAG   =: 4096 
AF_MAT_BLOCK_DIAG =: 8192  


iresult=: ,_1  NB. 4 byte integer
lresult=: ,_1  NB. 8 byte integer
dresult=: ,0.0 NB. double result
aresult=: ,_1  NB. af_array* result
qresult=: ,_1  NB. address of string

afx=: 4 : 0
r=. (lib,x)cd y
if. 0~:0{::r do. 'failed' assert 0 [echo x,LF,af_err_to_string 0{::r end.
r
)

NB. AFS tracks valid af_array values
afsadd=: 3 : '''''$y[AFS=: AFS,y'

NB. supported aftypes and corresponding J types
aftypes=: s64,f64 
jtypes =: 4   8

aftype_from_jtype=: 3 : 0
i=. jtypes i. 3!:0 y
'unsupported J type' assert i<#jtypes
i{::aftypes
)

jtype_from_aftype=: 3 : 0
i=. aftypes i. af_get_type y
'unsupported AF type' assert i<#aftypes
i{::jtypes
)

NB. validate cd args - needs work - validation avoids crashes!
vaf  =:  3 : 'y[''bad af array''assert (''''-:$y)*.y e. AFS'         NB. validate af_array
vrank=:  3 : 'y[''bad rank''    assert (''''-:$y)*.(4=3!:0 y)*.5>y'  NB. validate rank
vshape=: 3 : 'y[''bad shape''   assert (1=#$y)*.(4=3!:0 y)*.5>#y'    NB. validate shape
vtype=:  3 : 'y[''bad type''    assert y e. aftypes'                 NB. validate af type
vdim=:   3 : 'y[''bad dim''     assert (''''-:$y)*.(4=3!:0 y)*.5>y'  NB. validate dimension

NB. af_... verbs

NB. cd calls
NB. out values are not in y and are set as
NB.  aresult, iresult, lresult, or qresult as required
NB. out values are returned

af_create_array=: 3 : 0
afsadd 1{::'af_create_array x * * x * x' afx aresult;(rcc y);(vrank #$y);(vshape $y);aftype_from_jtype y
)

NB. constant is a double - coerced to type
af_constant=: 3 : 0
'val shape type'=. y
afsadd 1{::'af_constant x * d x * x'afx aresult;val;(vrank #shape);(vshape shape);vtype type
)

af_constant_long=: 3 : 0
'val shape'=. y
afsadd 1{::'af_constant_long x * x x *'afx aresult;val;(vrank #shape);vshape shape
)

af_identity=: 3 : 0
'shape type'=. y
afsadd 1{::'af_identity x * x * x'afx aresult;(vrank #shape);(vshape shape);vtype type
)

af_randu=: 3 : 0
's type'=. y
afsadd 1{::'af_randu x * x * x'afx aresult;(vrank #s);(vshape s);vtype type
)

af_randn=: 3 : 0
's type'=. y
afsadd 1{::'af_randn x * x * x'afx aresult;(vrank #s);(vshape s);vtype type
)

NB. create sequence - start,end,step
seq=: 3 : 0
'start end step'=. y
if. start<end do. assert 0<step end.
if. start>end do. assert 0>step end.
start+step*i.1+<.(|end-start)%|step
)

NB. row/col major order kludge - note reverses rcc
get=: 3 : 0
type=.  af_get_type y
ndims=. af_get_numdims y
dims=.  |.ndims{.af_get_dims y
data=.  (*/dims)$;(aftypes i. type){00;0.0
|:dims$af_get_data_ptr data;y
)

NB. get first element of af aray
get_scalar=: 3 : 0
data=.  ,;(aftypes i. af_get_type y){00;0.0
''$1{::'af_get_scalar x * x'afx data;y
)

SPARSE_DISPLAY=: 0 : 0
display/af_print sparse array messes up ref counts - freeall fails
   NO_SPARSE_DISPLAY_jaf_=: 0 NB. allow display and avoid freeall check 
)

DISPLAYLIMIT=:     2000 NB. _1 for all
DISPLAYPRECISION=: 6

display=: 3 : 0
if. NO_SPARSE_DISPLAY *. af_is_sparse vaf y do. i.0 0[echo SPARSE_DISPLAY return. end.
a=. af_array_to_string (vaf y);DISPLAYPRECISION;1 NB. transpose
r=. memr a,0,_1
af_free_host a NB. free the host memory
DISPLAYLIMIT{.r
)

NB. af_print_array to console
af_print_array=: 3 : 0
if. NO_SPARSE_DISPLAY *.af_is_sparse vaf y do. i.0 0[echo SPARSE_DISPLAY return. end.
i.0 0['af_print_array x x'afx vaf y
)

af_info_string=: 3 : 0
memr (1{::'af_info_string x * x'afx qresult;y),0,_1
)

NB. AF_MAT_NONE for elided args
af_matmul=: 3 : 0
if. 2=#y do. y=. y,0;0 end.
vaf each 2{.y
afsadd 1{::'af_matmul x * x x x x'afx aresult;y
)

af_det=: 3 : 0
;1 2{'af_det x * * x'afx dresult;dresult;vaf y 
)
NB. moadics family - af_sin ...
mop=: 4 : 0
afsadd 1{::(x,' x * x') afx aresult;vaf y
)

NB. dyadics familty - af_add ... - af1;af2 [;batch_boolean]
dop=: 4 : 0
if. 2=#y do. y=. y,<0 end. 
vaf each 2{.y
afsadd 1{::(x,' x * x x x')afx aresult;y
)

NB. af_is_... family - af_is_double ...
is=: 4 : 0
_255=1{::(x,' x * x')afx lresult;y
)

NB. af_sum family
reduce=: 4 : 0
afsadd 1{::(x,' x * x x')afx aresult; (vaf>{.y);}.y
)

NB. af_sum_all family
reduce_all=: 4 : 0
;1 2{(x,' x * * x')afx dresult;dresult;vaf y
)

af_get_type=: 3 : 0
''$1{::'af_get_type x *i x'afx iresult;vaf y
)

af_get_numdims=: 3 : 0
''$1{::'af_get_numdims x *i x'afx iresult;vaf y
)

af_get_dims=: 3 : 0
;1 2 3 4{'af_get_dims x * * * * x'afx lresult;lresult;lresult;iresult;vaf y
)

NB. result;af_array
af_get_data_ptr=: 3 : 0
vaf 1{::y
1{::'af_get_data_ptr x * x'afx y
)

NB. af_array_to_string (char **output, const char *exp, const af_array arr, const int precision, const bool transpose)
af_array_to_string=: 3 : 0
vaf 0{::y
1{::'af_array_to_string x * *c x x x'afx qresult;'no name';y
)

af_free_host=: 3 : 0
'af_free_host x x'afx y
)

af_free_device_v2=: 3 : 0
'af_free_device_v2 x x'afx y
)

af_err_to_string=: 3 : 0
ad=. 0{::(lib,'af_err_to_string x x')cd y
memr ad,0,_1
)

af_set_seed=: 3 : 0
'af_set_seed x x'afx y
)

af_get_seed=: 3 : 0
'af_get_seed x *'afx <iresult
) 

NB. memory management

NB. our af_array ref counting is dumb and assumes count of 1
release=: 3 : 0"0
r=. 'af_release_array x x'afx vaf y
AFS=: AFS-.y
r
)

freeall=: 3 : 0
release AFS
af_device_gc''
if. -.NO_SPARSE_DISPLAY do. i.0 0 return. end.
assert 0=af_device_mem_info''
i.0 0
)

af_eval=: 3 : 0
i.0 0['af_eval x x'afx vaf y
)

af_sync=: 3 : 0
i.0 0['af_sync x x'afx y NB. x is device - user _1
)

af_device_gc=: 3 : 0
i.0 0['af_device_gc x'afx''
)

NB. bytes,buffers,lock_bytes,lock_buffers
af_device_mem_info=: 3 : 0
}.;'af_device_mem_info x * * * *'afx iresult;iresult;iresult;iresult
)

af_tile=: 3 : 0
vaf 0{::y
afsadd 1{::'af_tile x * x x x x x'afx aresult;y
)

af_transpose=: 3 : 0
vaf 0{::y
afsadd 1{::'af_transpose x * x x'afx aresult;y
)

af_flat=: 3 : 0
vaf 0{::y
afsadd 1{::'af_flat x * x'afx aresult;y
)

NB. dim;af1;af2
af_join=: 3 : 0
afsadd 1{::'af_join x * x x x'afx aresult;y
)

af_index=: 3 : 0
'in dim seqs'=. y
vaf in
vdim dim=. 00+dim
seqs=. 0.0+,seqs
assert (3*dim)=#seqs
afsadd 1{::'af_index x * x x *'afx aresult;in;dim;seqs
)

af_inverse=: 3 : 0
vaf y
afsadd 1{::'af_inverse x * x x'afx aresult;y;0
)

NB. sparse

af_create_sparse_array_from_dense=: 3 : 0
vaf 0{::y
afsadd 1{::'af_create_sparse_array_from_dense x * x x'afx aresult;y NB. AF_STORAGE_CSR
)

af_sparse_get_info=: 3 : 0
;1 2 3{'af_sparse_get_info x * * * *i x'afx aresult;aresult;aresult;iresult;vaf y
)

af_get_data_ref_count=: 3 : 0
''$1{::'af_get_data_ref_count x *i x'afx iresult;vaf y
)

NB. stuff that may become obsolete
preload=: 0 : 0
export LD_PRELOAD... required before starting J

this system will crash due to mismatch between ubuntu and arrayfire libs

web search: MKL FATAL ERROR: Cannot load libmkl_avxavx2.so or libmkl_def.so

fix is to export LD_PRELOAD=... before starting J

*** afrunjhs.sh - script to run JHS with preload
#!/bin/bash
export LD_PRELOAD=/opt/arrayfire/lib64/libmkl_def.so:/opt/arrayfire/lib64/libmkl_avx2.so:/opt/arrayfire/lib64/libmkl_core.so:/opt/arrayfire/lib64/libmkl_intel_lp64.so:/opt/arrayfire/lib64/libmkl_intel_thread.so:/opt/arrayfire/lib64/libiomp5.so
j903/bin/jconsole ~addons/ide/jhs/config/jhs.cfg
***

*** afrunjqt.sh - script to run Jqt with preload
#!/bin/bash
export LD_PRELOAD=/opt/arrayfire/lib64/libmkl_def.so:/opt/arrayfire/lib64/libmkl_avx2.so:/opt/arrayfire/lib64/libmkl_core.so:/opt/arrayfire/lib64/libmkl_intel_lp64.so:/opt/arrayfire/lib64/libmkl_intel_thread.so:/opt/arrayfire/lib64/libiomp5.so
j903/bin/jqt
***
)

NB. from test suite tsu.ijs - return expected error - used in Jd
etx_z_=: 1 : 'u :: (<:@(13!:11)@i.@0: >@{ 9!:8@i.@0:)'

 