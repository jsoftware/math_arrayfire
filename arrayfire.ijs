NB. J arrayfire cd bindings

0 : 0
issues:
af_matmul_ and xafmatmul with 205 error (different types) - memory leak of 1 object of 1024 bytes
)

coclass'jaf'

man=: 3 : 0
d=. toJ fread JAFP,'man.txt'
bd=. <;.2 d
i=. ((<'*** ')=4{.each bd)#i.#bd
s=. i{bd
if. ''-:y do. ;(<'   man_jaf_ '''),each(<'''',LF),each~}:each 4}.each s return. end.
if. ''-:y do. y=. 'man' end.
i=. ((#y){.each 4}.each bd)i.<y
'invalid'assert i<#bd
bd=. i}.bd
i=. (4{.each }.bd) i. <'*** '
;i{.bd
)

3 : 0''
select. UNAME
case. 'Linux'  do. t=. 'libafxxx.so' NB. depends on ldconfig
case. 'Win'    do. t=. 'afxxx.dll'   NB. depends on AF_PATH and PATH env vars
case. 'Darwin' do. t=. (fexist t-.'x'){::'libafxxx.dylib';t=. '/opt/arrayfire/lib/libafxxx.dylib' NB. homebrew vs full path
case.          do. 'host not supported'assert 0 
end.
libtemplate=: t,' '

NB. ensure different (production vs development) packages are not both loaded
n=. '/arrayfire.ijs'
d=. jpath each 4!:3''
f=. (;(<n)-:each (-#n){.each d)#d

if. UNAME-:'Darwin'do. NB. macos upper/lower case
 f=. tolower each f
 if. 2=#f do. if. =/f do. f=. {.f end. end.
end.

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

NB. valid tuts in preferred order
tuts=: ;:'basic create display index inverse memory qmp qgridxy sparse xaf_cpp'
 
if. _1=nc<'lib' do.
 AFS=: ''     NB. valid normal af_array values
 AFSHOLD=: '' NB. valid af_arrays that won't be released
 lib=: 'invalidlib'
 backend=: ''
 LASTMEMINFO=: 0 0 0 0
end.

if. _1=nc<'nointro' do. nointro=: 1[echo man'intro' end.
)

load JAFP,'families.ijs' NB. define verbs for mop/dop/is/...
load JAFP,'qcommon.ijs'   NB. jmp ...

NB. y is 'cpu' or 'cuda' or 'opencl'
NB. af_set_backend is implicit in the lib that is used
init=: 3 : 0
'invalid backend'assert (<y) e. ;:'cpu cuda opencl'
if. backend-:y do. i.0 0 return. end.
t=. libtemplate rplc 'xxx';y
m=. afmissing
try. (t,'af_get_seed x *')cd <iresult
catch.
 if. y-:'cuda' do.
  m=. cudamissing
  try. ((libtemplate rplc 'xxx';'cpu'),'af_get_seed x *')cd <iresult
  catch. m=. afmissing end.
 end. 
 ('load library failed: ',t)assert 0 [ echo m
end.

if. (UNAME-:'Linux')*.y-:'cpu' do.
 try.
  'libmkl_def.so foo x'cd'' NB. check if required LD_PRELOAD has been done
 catch.
  if. 1 0-:cder'' do. 
   echo preload
   'required LD_PRELOAD missing'assert 0
  end.
 end. 
end.

lib=: t
backend=: y
i.0 0
)

NB. close current backend - allows new init
NB. convenient for casual testing but does not always work and may lead to crashes
close=: 3 : 0
freeall''
backend=: ''
lib=: 'invalidlib'
i.0 0
)

tut=: 3 : 0
if. IFJHS do.
 runtut=: spx_jsp_
else.
 require'labs/labs'
 runtut=: lab_z_
end.
if. ''-:y do.
 ;(<'   tut_jaf_ '''),each(<'''',LF),~each tuts
 return.
end. 
f=. JAFP,'tutorial/',(dltb y),'.ijs'
'tutorial does not exist'assert fexist f
runtut f
)

tests=: 3 : 0
d=. 1 dir JAFP,'tutorial'
NB. (<''''),each '''',each~d
)

NB. from test suite tsu.ijs - return expected error
etx_z_=: 1 : 'u :: (<:@(13!:11)@i.@0: >@{ 9!:8@i.@0:)'

rcc=: $ $ [: , |: NB. row major order to col convert

rcc=: 3 : '($y)$,|:y' NB. row major order to col convert

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
if. 0~:0{::r do. 'af cd call error result' assert 0 [LASTERROR=: (":0{::r),' ',(x{.~x i.' '),' ',af_err_to_string 0{::r end.
r
)

NB. AFS tracks valid normal af_array values
afsadd=: 3 : '''''$y[AFS=: AFS,y'

NB. supported aftypes and corresponding J types
aftypes=: s64, f64 
jtypes =: 4  , 8

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
vaf=:    3 : 'y[''bad af array''assert (''''-:$y)*.y e. AFS'"0          NB. validate af_array(s)
vrank=:  3 : 'y[''bad rank''    assert (''''-:$y)*.(4=3!:0 y)*.5>y'   NB. validate rank
vshape=: 3 : 'y[''bad shape''   assert (1=#$y)*.(4=3!:0 y)*.5>#y'     NB. validate shape
vtype=:  3 : 'y[''bad type''    assert y e. aftypes'                  NB. validate af type
vtype=:  3 : 'y'
vdim=:   3 : 'y[''bad dim''     assert (''''-:$y)*.(4=3!:0 y)*.5>y'   NB. validate dimension

NB. af_... verbs

NB. cd calls
NB. out values are not in y and are set as
NB.  aresult, iresult, lresult, or qresult as required
NB. out values are returned

NB. (type [,rccflag]) f converts y to type and rccflag 0 avoids rcc
af_create_array=: 3 : 0
afsadd 1{::'af_create_array x * * x * x' afx aresult;(rcc y);(vrank #$y);(vshape $y);aftype_from_jtype y
:
'type rccflag'=. 2{.x,1 NB. default 1 does rcc
c=. (vrank #$y);vshape $y
d=. ,rcc^:rccflag y
select. type
case. f64;s64 do.
case. f32 do.
 d=. 1 fc d
case.         do. 'unsupported aftype' assert 0
end.
afsadd 1{::'af_create_array x * * x * x' afx aresult;d;c,<type
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
select. type
case. s32 do.
 data=.  (4**/dims)$;{.a.
 |:dims$_2 ic af_get_data_ptr data;y
case. f32 do.
 data=.  (4**/dims)$;{.a.
 |:dims$_1 fc af_get_data_ptr data;y
case. f64 do.
 data=.  (*/dims)$0.0
 |:dims$af_get_data_ptr data;y
case. s64 do.
 data=.  (*/dims)$00
 |:dims$af_get_data_ptr data;y
case.     do.
 'unable to get that type'assert 0
end. 
)

NB. get first element of af array
get_scalar=: 3 : 0
data=.  ,;(aftypes i. af_get_type y){00;0.0
''$1{::'af_get_scalar x * x'afx data;y
)

SPARSE_DISPLAY=: 'display/af_print sparse messes up ref counts'

DISPLAYLIMIT=:     2000 NB. _1 for all
DISPLAYPRECISION=: 6

display=: 3 : 0
SPARSE_DISPLAY assert -.af_is_sparse y
a=. af_array_to_string (vaf y);DISPLAYPRECISION;1 NB. transpose
r=. memr a,0,_1
af_free_host a NB. free the host memory
DISPLAYLIMIT{.r
)

NB. af_print_array to console
af_print_array=: 3 : 0
SPARSE_DISPLAY assert -.af_is_sparse y
i.0 0['af_print_array x x'afx vaf y
)

af_info_string=: 3 : 0
memr (1{::'af_info_string x * x'afx qresult;y),0,_1
)

af_retain_array=: 3 : 0
'af_retain_array x * x'afx aresult;vaf y
)

NB. AF_MAT_NONE for elided args
af_matmul=: 3 : 0
if. 2=#y do. y=. y,0 0 end.
vaf 0{y
vaf  1{y
afsadd 1{::'af_matmul x * x x x x'afx aresult;<"0 y
)

af_det=: 3 : 0
;1 2{'af_det x * * x'afx dresult;dresult;vaf y 
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

af_err_to_string=: 3 : 0
ad=. 0{::(lib,'af_err_to_string x x')cd y
memr ad,0,_1
)

af_get_last_error=: 3 : 0
(lib,'af_get_last_error x * *')cd y
)

af_set_seed=: 3 : 0
'af_set_seed x x'afx y
)

af_get_seed=: 3 : 0
'af_get_seed x *'afx <iresult
) 

NB. memory management

NB. device garbage collection
af_device_gc=: 3 : 0
i.0 0['af_device_gc x'afx''
)

NB. bytes,buffers,lock_bytes,lock_buffers
af_device_mem_info=: 3 : 0
}.;'af_device_mem_info x * * * *'afx iresult;iresult;iresult;iresult
)

NB. our af_array ref counting is dumb and assumes count of 1
NB. do not release if the af_array is held
release=: 3 : 0"0
y=. AFSHOLD-.~vaf y
if. 1=#y do.
 'af_release_array x x'afx y
 AFS=: AFS-.y
end. 
i.0 0
)

NB. free device memory
NB. free AFSHOLD , AFS , gc
NB. free AFS arrays, gc, and report mem info
free=: 3 : 0
release AFS
af_device_gc''
af_device_mem_info''
)

NB. free AFS after AFSHOLD=: '', gc, report mem info
freeall=: 3 : 0
AFSHOLD=: ''
free''
)

chkleak=: 3 : 0
'first do: freeall_jaf_''''  'assert 0=#AFS
t=. af_device_mem_info''
if. t-:0 0 0 0 do. 'no memory leak' return. end.
echo (":t),LF,memleak
'unexpected af_device_mem_info result'assert (2{.t)-:2}.t
'leak not explained by 1024 bytes per object from exception'assert ({.t)=1024*1{t
)

hold=: 3 : 0
AFSHOLD=: ~.AFSHOLD,vaf y
)

letgo=: 3 : 0
vaf y
AFSHOLD=: AFSHOLD-.y
)

af_free_host=: 3 : 0
'af_free_host x x'afx y
)

af_free_device_v2=: 3 : 0
'af_free_device_v2 x x'afx y
)

NB. memory management end

af_eval=: 3 : 0
i.0 0['af_eval x x'afx vaf y
)

af_sync=: 3 : 0
i.0 0['af_sync x x'afx y NB. x is device - user _1
)

NB. crashes if sparse
af_get_data_ref_count=: 3 : 0
''$1{::'af_get_data_ref_count x *i x'afx iresult;vaf y
)

af_tile=: 3 : 0
vaf 0{::y
afsadd 1{::'af_tile x * x x x x x'afx aresult;y
)

af_transpose=: 3 : 0
vaf 0{y
afsadd 1{::'af_transpose x * x x'afx aresult;<"0 y
)

af_transpose_inplace=: 3 : 0
vaf 0{y
i.0 0['af_transpose_inplace x x x'afx y
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

AF_STORAGE_DENSE     =: 0   
AF_STORAGE_CSR       =: 1   
AF_STORAGE_CSC       =: 2   
AF_STORAGE_COO       =: 3    


NB. data;rows;cols;AF_STORAGE_...;af type;af numdims;af_dims
getsparse=: 3 : 0
'must be sparse'assert af_is_sparse y
a=. af_sparse_get_info vaf y
r=. (get 0{a);(get 1{a);(get 2{a);({:a);(af_get_type y);(af_get_numdims y);af_get_dims y
release"0 3{.a
r
)

j_from_sparse=: 3 : 0
'd r c t type rank shape'=. y
assert AF_STORAGE_CSR=t
assert 2=rank
'rows cols'=.  rank{.shape
rc=. }.}:(r,0)-0,r NB. data in each row
i=. c+;(cols*i.rows)*each rc#each 1
a=. d i}(rows*cols)$0
(rows,cols)$a
)

af_create_sparse_array_from_dense=: 3 : 0
vaf 0{::y
afsadd 1{::'af_create_sparse_array_from_dense x * x x'afx aresult;y NB. AF_STORAGE_CSR
)

af_sparse_get_info=: 3 : 0
'must be sparse'assert af_is_sparse vaf y
r=. ;1 2 3 4{'af_sparse_get_info x * * * *i x'afx aresult;aresult;aresult;iresult;y
afsadd 3{.r
r
)

NB. fails in cuda
af_sparse_convert_to=: 3 : 0
vaf 0{::y
afsadd 1{::'af_sparse_convert_to x * x x'afx aresult;y
)

NB. fails in cuda
af_sparse_to_dense=: 3 : 0
afsadd 1{::'af_sparse_to_dense x * x'afx aresult;vaf y
)

afmissing=: 0 : 0
ArrayFire not installed or not installed where init is looking
   man_jaf_'install arrayfire' NB. for more info
)

cudamissing=: 0 : 0
Nvidia cuda is not installed or not installed where init is looking
   man_jaf_'install cuda' NB. for more info
)

memleak=: 0 : 0
freeall did not release all device memory
exceptions (LASTERROR) - leak 1 object of 1024 bytes
)

preload=: 0 : 0
LD_PRELOAD is required
   man_jaf_'preload' NB. more info and workaround
)   
