NB. create AF array tests and examples

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
