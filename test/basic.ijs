NB. basic tests and examples

mp=. +/ . *

freeall_jaf_''  NB. release all AF arrays and do device garbage collection

af_info_string_jaf_ 1 NB. verbose

[afai=. af_create_array_jaf_ jai=. i.2 4
NB. afai is integer handle to array in device space (cpu/gpu/opencl)
get_jaf_ afai NB. get device array back as j array
assert jai-:get_jaf_ afai

display_jaf_ afai        NB. get AF text display of afai data
af_print_array_jaf_ afai NB. display afai array on console

assert 'assertion failure'-:get_jaf_ etx 123 NB. test that bad AF array does not crash

0 : 0
J  array is stored in row major order
AF array is stored in col major order

af_create_array applies verb rcc to J array before setting the AF array
get reverses the process when setting a J array from AF array data

J data to set an AF array with (i.2 3) is: 0 3 1 4 2 5
)

assert ({.{.jai)=get_scalar_jaf_ afai

t=.'no name',LF,'[2 4 1 1]',LF
assert t-:(#t){.display_jaf_ afai

afad=. af_create_array_jaf_ jad=. 0.5+?4 4$100
afbd=. af_create_array_jaf_ jbd=. 0.3+?4 4$100

afmm=. af_matmul_jaf_ afad;afbd
assert (jad mp jbd)-:get_jaf_ afmm

af_det_jaf_ afad NB. matrix determinate

NB. modadic
assert (1 o. jad)-:get_jaf_ af_sin_jaf_ afad
assert (2 o. jad)-:get_jaf_ af_cos_jaf_ afad

NB. dyadics
assert (jad+jbd)-:get_jaf_ af_add_jaf_ afad;afbd
assert (jad+jbd)-:get_jaf_ af_add_jaf_ afad;afbd
assert (jad%jbd)-:get_jaf_ af_div_jaf_ afad;afbd

NB. af_is...
assert 1=af_is_double_jaf_ afad
assert 0=af_is_empty_jaf_  afad

NB. reduceall
assert (0,~+/+/jad)-:af_sum_all_jaf_ afad
assert (0,~*/*/jad)-:af_product_all_jaf_ afad

NB. reduce dimension
NB. row vs col major order!
NB. af_... dimension is 0 origin and from the view of col major
NB. J +/"1 maps to AF 1 - J +/"2 maps to AF 0
assert (+/"1 jad)-: get_jaf_ af_sum_jaf_     afad;1
assert (+/"2 jad)-:,get_jaf_ af_sum_jaf_     afad;0 NB. , is required!
assert (*/"1 jad)-: get_jaf_ af_product_jaf_ afad;1

AFS_jaf_ NB. list of valid AF array handles
freeall_jaf_'' NB. release all AF arrays and do device garbage collection
assert 0=#AFS_jaf_
