coclass 'jaf'

NB. moadics family - af_sin ...
mop=: 4 : 0
afsadd 1{::(x,' x * x') afx aresult;vaf y
)

NB. dyadics familty - af_add ... - af1,af2 [,batch_boolean]
dop=: 4 : 0
if. 2=#y do. y=. y,0 end. 
vaf"0[2{.y
afsadd 1{::(x,' x * x x x')afx aresult;<"0 y
)

NB. af_is_... family - af_is_double ...
is=: 4 : 0
_255=1{::(x,' x * x')afx lresult;vaf y
)

NB. af_sum family
reduce=: 4 : 0
vaf {.y
afsadd 1{::(x,' x * x x')afx aresult;<"0 y
)

NB. af_sum_all family
reduce_all=: 4 : 0
;1 2{(x,' x * * x')afx dresult;dresult;vaf y
)

af_abs=: 'af_abs'mop]
af_acos=: 'af_acos'mop]
af_acosh=: 'af_acosh'mop]
af_arg=: 'af_arg'mop]
af_asin=: 'af_asin'mop]
af_asinh=: 'af_asinh'mop]
af_atan=: 'af_atan'mop]
af_atanh=: 'af_atanh'mop]
af_bitnot=: 'af_bitnot'mop]
af_cbrt=: 'af_cbrt'mop]
af_ceil=: 'af_ceil'mop]
af_conjg=: 'af_conjg'mop]
af_cos=: 'af_cos'mop]
af_cosh=: 'af_cosh'mop]
af_cplx=: 'af_cplx'mop]
af_erf=: 'af_erf'mop]
af_erfc=: 'af_erfc'mop]
af_exp=: 'af_exp'mop]
af_expm1=: 'af_expm1'mop]
af_factorial=: 'af_factorial'mop]
af_flat=: 'af_flat'mop]
af_floor=: 'af_floor'mop]
af_imag=: 'af_imag'mop]
af_isinf=: 'af_isinf'mop]
af_isnan=: 'af_isnan'mop]
af_iszero=: 'af_iszero'mop]
af_lgamma=: 'af_lgamma'mop]
af_log=: 'af_log'mop]
af_log10=: 'af_log10'mop]
af_log1p=: 'af_log1p'mop]
af_log2=: 'af_log2'mop]
af_not=: 'af_not'mop]
af_pow2=: 'af_pow2'mop]
af_real=: 'af_real'mop]
af_retain_array=: 'af_retain_array'mop]
af_round=: 'af_round'mop]
af_rsqrt=: 'af_rsqrt'mop]
af_sat=: 'af_sat'mop]
af_sigmoid=: 'af_sigmoid'mop]
af_sign=: 'af_sign'mop]
af_sin=: 'af_sin'mop]
af_sinh=: 'af_sinh'mop]
af_sparse_get_col_idx=: 'af_sparse_get_col_idx'mop]
af_sparse_get_row_idx=: 'af_sparse_get_row_idx'mop]
af_sparse_get_values=: 'af_sparse_get_values'mop]
af_sqrt=: 'af_sqrt'mop]
af_tan=: 'af_tan'mop]
af_tanh=: 'af_tanh'mop]
af_tgamma=: 'af_tgamma'mop]
af_trunc=: 'af_trunc'mop]

af_add=: 'af_add'dop]
af_and=: 'af_and'dop]
af_atan2=: 'af_atan2'dop]
af_bitand=: 'af_bitand'dop]
af_bitor=: 'af_bitor'dop]
af_bitshiftl=: 'af_bitshiftl'dop]
af_bitshiftr=: 'af_bitshiftr'dop]
af_bitxor=: 'af_bitxor'dop]
af_div=: 'af_div'dop]
af_eq=: 'af_eq'dop]
af_ge=: 'af_ge'dop]
af_gt=: 'af_gt'dop]
af_hypot=: 'af_hypot'dop]
af_le=: 'af_le'dop]
af_lt=: 'af_lt'dop]
af_maxof=: 'af_maxof'dop]
af_minof=: 'af_minof'dop]
af_mod=: 'af_mod'dop]
af_mul=: 'af_mul'dop]
af_neq=: 'af_neq'dop]
af_or=: 'af_or'dop]
af_pow=: 'af_pow'dop]
af_rem=: 'af_rem'dop]
af_root=: 'af_root'dop]
af_sub=: 'af_sub'dop]

af_is_bool=: 'af_is_bool'is]
af_is_column=: 'af_is_column'is]
af_is_complex=: 'af_is_complex'is]
af_is_double=: 'af_is_double'is]
af_is_empty=: 'af_is_empty'is]
af_is_floating=: 'af_is_floating'is]
af_is_half=: 'af_is_half'is]
af_is_integer=: 'af_is_integer'is]
af_is_linear=: 'af_is_linear'is]
af_is_owner=: 'af_is_owner'is]
af_is_real=: 'af_is_real'is]
af_is_realfloating=: 'af_is_realfloating'is]
af_is_row=: 'af_is_row'is]
af_is_scalar=: 'af_is_scalar'is]
af_is_single=: 'af_is_single'is]
af_is_sparse=: 'af_is_sparse'is]
af_is_vector=: 'af_is_vector'is]

af_accum=: 'af_accum'reduce]
af_all_true=: 'af_all_true'reduce]
af_any_true=: 'af_any_true'reduce]
af_count=: 'af_count'reduce]
af_diff1=: 'af_diff1'reduce]
af_diff2=: 'af_diff2'reduce]
af_max=: 'af_max'reduce]
af_min=: 'af_min'reduce]
af_product=: 'af_product'reduce]
af_sum=: 'af_sum'reduce]

af_all_true_all=: 'af_all_true_all'reduce_all]
af_any_true_all=: 'af_any_true_all'reduce_all]
af_count_all=: 'af_count_all'reduce_all]
af_max_all=: 'af_max_all'reduce_all]
af_mean_all=: 'af_mean_all'reduce_all]
af_min_all=: 'af_min_all'reduce_all]
af_product_all=: 'af_product_all'reduce_all]
af_stdev_all=: 'af_stdev_all'reduce_all]
af_sum_all=: 'af_sum_all'reduce_all]
