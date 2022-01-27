NB. loadd this test script to validate J-ArrayFire bindings
NB. and to see working examples with sparse data

freeall_jaf_''  NB. release all AF arrays and do device garbage collection

NB. x data elements in y shape array
cre8=: 4 : 0
n=. */y
i=. x?n
y$(1.0+i.x) i}n$0
)

tstsparse=: 4 : 0
af=: af_create_array_jaf_ data=: x cre8 y
saf=: af_create_sparse_array_from_dense_jaf_ af;AF_STORAGE_CSR_jaf_
)

12 tstsparse 10 10
[data

af=. af_create_array_jaf_ data

saf=. af_create_sparse_array_from_dense_jaf_ af;1 NB. CSR
[r=. getsparse_jaf_ saf

h=. 'values';'rows';'cols';'1 is CSR';'af type';'rank';'af shape'
h,.r

[a=. j_from_sparse_jaf_ r
assert a-:data

bf=. af_create_array_jaf_ b=.10 10$ 134.5 145.3 156.2

q=. af_matmul_jaf_ saf,bf,0 0
NB. display_jaf_ q NB. useful if it works, but does not work on all platforms

assert (get_jaf_ q)-:a (+/ . *) b

freeall_jaf_''  NB. release all AF arrays and do device garbage collection
