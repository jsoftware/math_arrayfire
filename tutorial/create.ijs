freeall_jaf_'' NB. release all AF arrays and do device garbage collection

afai=. af_create_array_jaf_ i.3 4
get_jaf_          afai
af_get_type_jaf_     afai
aftypes_jaf_,.jtypes_jaf_ NB. aftype and corresponding jtype
af_get_numdims_jaf_ afai
af_get_dims_jaf_     afai NB. af arrays always have shape with 4 elements

afad=. af_create_array_jaf_ 2.3+i.3 4
get_jaf_          afad

afshort=. f32_jaf_ af_create_array_jaf_ 1.5+i.2 2 NB. 32bit float
af_get_type_jaf_   afshort NB. 0 is 32bit float type
get_jaf_ afshort

afcd=. af_constant_jaf_ 1234.56;2 3;f64_jaf_
get_jaf_ afcd
assert 1234.56=,get_jaf_ afcd
assert f64_jaf_=af_get_type_jaf_ afcd

afci=. af_constant_jaf_ 1234.123;2 3;s64_jaf_ NB. double constant coerced to s64 
get_jaf_ afci
assert 1234=,get_jaf_ afci
assert s64_jaf_=af_get_type_jaf_ afci

afcbigi=. af_constant_long_jaf_ 9223372036854775807;2 3 NB. big int constant 
assert 9223372036854775807=,get_jaf_ afcbigi

cid=. af_identity_jaf_ 3 3;s64_jaf_
get_jaf_ cid

cid=. af_identity_jaf_ 3 3;f64_jaf_
get_jaf_ cid
assert 8=3!:0 get_jaf_ cid NB. identity matrix is double

aru=. af_randu_jaf_ 2 3;s64_jaf_ NB. uniform random ints
get_jaf_ aru

aru=. af_randu_jaf_ 2 3;f64_jaf_ NB. uniform random doubles
get_jaf_ aru

'assertion failure'-:af_randn_jaf_ etx 2 3;s64_jaf_ NB.normal random ints

arn=. af_randn_jaf_ 2 3;f64_jaf_ NB.normal random doubles
get_jaf_ arn

freeall_jaf_'' NB. release all AF arrays and do device garbage collection
