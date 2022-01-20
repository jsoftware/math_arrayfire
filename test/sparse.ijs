NB. loadd this test script to validate J-ArrayFire bindings
NB. and to see working examples with sparse data

freeall_jaf_''  NB. release all AF arrays and do device garbage collection

mp=. +/ . *

af=. af_create_array_jaf_ a=. 10 10$65.4 0 0 0 23.5 0 0 0 0 95.6 0 0 0
saf=. af_create_sparse_array_from_dense_jaf_ af;1 NB. csr
display_jaf_ saf
af_print_array_jaf_ saf

bf=. af_create_array_jaf_ b=.10 10$ 134.5 145.3 156.2

q=. af_matmul_jaf_ saf;bf;0;0
display_jaf_ q

assert (get_jaf_ q)-:a mp b

freeall_jaf_''  NB. release all AF arrays and do device garbage collection
