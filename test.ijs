NB. loadd this test script to validate J-ArrayFire bindings
NB. and to see working examples

NB. from test suite tsu.ijs - return expected error
etx_z_=: 1 : 'u :: (<:@(13!:11)@i.@0: >@{ 9!:8@i.@0:)'

mp=: +/ . *
ae=: 'assertion failure'

release_jaf_ AFS_jaf_ NB. release all af_arrays
assert 0=#AFS_jaf_

af_info_string_jaf_ 1 NB. verbose

ai=: af_create_array_jaf_ jai=: ?4 4$100
assert jai-:get_jaf_ ai

assert ({.{.jai)=get_scalar_jaf_ ai

cd=. af_constant_jaf_ 1234.56;2 3;f64_jaf_
assert 1234.56=get_jaf_ cd
assert f64_jaf_=af_get_type_jaf_cd

ci=. af_constant_jaf_ 1234.56;2 3;s64_jaf_ NB. double coerced to s64
assert 1234=get_jaf_ ci
assert s64_jaf_=af_get_type_jaf_ci

ci=. af_constant_long_jaf_ 1234;2 3
assert 134=get_jaf_ ci

cid=. af_identity_jaf_ 3 3;2

aru=: af_randu_jaf_ 2 3;s64_jaf_ NB. uniform random ints
get_jaf_ aru

arn=: af_randn_jaf_ 2 3;f64_jaf_ NB.normal random doubles
get_jaf_ arn

assert ae-:display_jaf_ etx 123 NB. test that bad af_array does not crash

t=.'no name',LF,'[4 4 1 1]',LF
assert t-:(#t){.display_jaf_ ai

af=: af_create_array_jaf_ jaf=: 0.5+?4 4$100
bf=: af_create_array_jaf_ jbf=: 0.3+?4 4$100

amm=: af_matmul_jaf_ af;bf;AF_MAT_TRANS_jaf_;AF_MAT_TRANS_jaf_ NB. matric muliply
assert (|:jaf mp jbf)-:get_jaf_ amm NB. yet another transpose

adet=: af_det_jaf_ af NB. determinate


NB. modadic
assert (1 o. jaf)-:get_jaf_ af_sin_jaf_ af
assert (2 o. jaf)-:get_jaf_ af_cos_jaf_ af

NB. dyadics
assert (jaf+jbf)-:get_jaf_ af_add_jaf_ af;bf;0 NB. batch 0
assert (jaf+jbf)-:get_jaf_ af_add_jaf_ af;bf;1 NB. batch 1
assert (jaf%jbf)-:get_jaf_ af_div_jaf_ af;bf;0 

NB. af_is...
assert 1=af_is_double_jaf_ af
assert 0=af_is_empty_jaf_  af


NB. reduce dimension
assert (+/jaf)-:get_jaf_ af_sum_jaf_ af;1
assert (+/"1 jaf)-:,get_jaf_ af_sum_jaf_ af;0 NB. , is required!
assert (*/jaf)-:get_jaf_ af_product_jaf_ af;1

NB. reduceall
assert (0,~+/+/jaf)-:af_sum_all_jaf_ af
assert (0,~*/*/jaf)-:af_product_all_jaf_ af

NB. spiralled data
a=. i.2 3
afa=. af_create_array_jaf_ a
a
display_jaf_ afa

NB. release all at end
release_jaf_ AFS_jaf_ NB. release all af_arrays
assert 0=#AFS_jaf_
