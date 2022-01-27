NB. Combining re-ordering functions to enumerate grid coordinates
NB. https://arrayfire.org/docs/matrixmanipulation.htm

freeall_jaf_''  NB. release all AF arrays and do device garbage collection

gridxy=. 3 : 0
n=. y
NB. tile(seq(1, n), 1, n)
s=. af_create_array_jaf_ seq_jaf_ 1,n,1
a=. af_tile_jaf_ s;1;n;1;1 NB. tile(seq(1, n), 1, n)
b=. af_transpose_jaf_ a;0
c=. af_flat_jaf_ b
d=. af_tile_jaf_ s;n;1;1;1
e=. af_join_jaf_ 1;d;c
get_jaf_ e
)

gridxy 3

freeall_jaf_''  NB. release all AF arrays and do device garbage collection
