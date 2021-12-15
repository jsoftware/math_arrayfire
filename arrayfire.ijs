NB. J arrayfire cd bindings

coclass'jaf'

man=: 0 : 0
J-ArrayFire cd bindings

if unfamiliar with arrayfire, browse: https://arrayfire.org

   init_jaf_'cpu' NB. 'cuda' or 'opencl'
   runtest_jaf_'' NB. loadd test script - study for use examples

   JAFP_z_ NB. path to scripts - usually ~addons/math/arrayfire

   fread JAFP,'install/install.txt' NB. arrayfire install hints
   
util/util.ijs tools that create files from c headers
 families.ijs     - J cd  bindings for families of routines
 util/proto.txt   - all arrayfire c protypes
 util/famcnts.txt - count and 1st member of each family with same prototype

row vs col major order
 J  array is row major - AF array is column major
 af_create_array creates an array with 'spiralled' data
 get reads the array back OK
 this needs to be better understood and handled
   
*** credits
Pascal Jasmin was the J-ArrayFire pioneer in 2015 with
 https://github.com/Pascal-J/Jfire
 
Alex Shroyer, in late 2021, did some new work and wrote a paper
 that comparied af_matmul with J mp

this addon started with a clean slate - it might be interesting 
 to see if it could be improved/replaced by the work of Pascal or Alex
)

3 : 0''
NB. ensure different (production vs development) packages are not both loaded
n=. '/arrayfire.ijs'
d=. jpath each 4!:3''
f=. (;(<n)-:each (-#n){.each d)#d
'can not mix different arrayfire packages' assert 1=#f
JAFP_z_=: (-<:#n)}.;f
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
select. UNAME
case. 'Linux' do.
 NB. check if required LD_PRELOAD has been done
 try.
  'libmkl_def.so foo x'cd''
 catch.
  if. 1 0-:cder'' do. 
   echo preload
   'required LD_PRELOAD missing'assert 0
  end.
 end. 
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
i.0 0
)

runtest=: 3 : 0
loadd JAFP,'test.ijs'
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


DISPLAYLIMIT=: 2000 NB. set to _1 for all

iresult=: ,_1  NB. 4 byte integer
lresult=: ,_1  NB. 8 byte integer
dresult=: ,0.0 NB. double result
aresult=: ,_1  NB. af_array* result
qresult=: ,_1  NB. address of string

afx=: 4 : 0
r=. (lib,x)cd y
if. 0~:0{::r do. 'failed' assert 0 [echo af_err_to_string 0{::r end.
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
'unsupported J type' assert i<#aftypes
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
afsadd 1{::'af_create_array x * * x * x' afx aresult;y;(vrank #$y);(vshape $y);aftype_from_jtype y
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

NB. our af_array ref counting is dumb and assumes count of 1
release=: 3 : 0"0
'af_release_array x x'afx vaf y
AFS=: AFS-.y
i.0 0
)

NB. get af_array as j_array
get=: 3 : 0
type=.  af_get_type y
ndims=. af_get_numdims y
dims=.  ndims{.af_get_dims y
data=.  (*/dims)$;(aftypes i. type){00;0.0
dims$af_get_data_ptr data;y
)

NB. get first element of af aray
get_scalar=: 3 : 0
data=.  ,;(aftypes i. af_get_type y){00;0.0
''$1{::'af_get_scalar x * x'afx data;y
)

NB. af_array;precision;transpose
display=: 3 : 0
if. 0=L.y do. y=. y;6;0 end.
vaf 0{::y
a=. af_array_to_string y
r=. memr a,0,_1
af_free_device_v2 a NB. free the memory!
DISPLAYLIMIT{.r
)

af_info_string=: 3 : 0
memr (1{::'af_info_string x * x'afx qresult;y),0,_1
)

af_matmul=: 3 : 0
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

NB. dyadics familty - af_add ... - af1;af2;batch_boolean
dop=: 4 : 0
vaf each 2{.y
afsadd 1{::(x,' x * x x x')afx aresult;y
)

NB. af_is_... family - af_is_double ...
is=: 4 : 0
_255=1{::(x,' x * x')afx lresult;y
)

NB. af_sum family
reduce=: 4 : 0
afsadd 1{::(x,' x * x x')afx arg__=: aresult; (vaf>{.y);}.y
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

NB. af_print_array (af_array arr)
af_print_array=: 3 : 0
(lib,' af_print_array x x')cd y
)

NB. af_array_to_string (char **output, const char *exp, const af_array arr, const int precision, const bool transpose)
af_array_to_string=: 3 : 0
1{::'af_array_to_string x * *c x x x'afx arg__=: qresult;'no name';y
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

NB. stuff that may become obsolete
preload=: 0 : 0
export LD_PRELOAD... required before starting J

this system will crash due to mismatch between ubuntu and arrayfire libs

web search: MKL FATAL ERROR: Cannot load libmkl_avxavx2.so or libmkl_def.so

fix is to export LD_PRELOAD=... before starting J

*** afrun.sh - script to run JHS with preload
#!/bin/bash
export LD_PRELOAD=/opt/arrayfire/lib64/libmkl_def.so:/opt/arrayfire/lib64/libmkl_avx2.so:/opt/arrayfire/lib64/libmkl_core.so:/opt/arrayfire/lib64/libmkl_intel_lp64.so:/opt/arrayfire/lib64/libmkl_intel_thread.so:/opt/arrayfire/lib64/libiomp5.so
j903/bin/jconsole ~addons/ide/jhs/config/jhs.cfg
***

)
 