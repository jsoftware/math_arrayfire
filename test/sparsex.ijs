freeall_jaf_''  NB. release all AF arrays and do device garbage collection

af=.   af_identity_jaf_ 5 5;f64_jaf_
saf=. af_create_sparse_array_from_dense_jaf_ af;1 NB. csr

freeall_jaf_''  NB. release all AF arrays and do device garbage collection
