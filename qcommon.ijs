coclass'jaf'

NB. mp - f64 - AF_MAT_TRANS for squares to avoid rcc overhead
qmp=: 4 : 0
freeall''
ls=. =/$x
rs=. =/$y
get af_matmul ((f64,-.ls)af_create_array x),((f64,-.rs)af_create_array y),ls,rs
)

NB. mp - f32 - AF_MAT_TRANS for squares to avoid rcc overhead
qmp_f32=: 4 : 0
freeall''
ls=. =/$x
rs=. =/$y
get af_matmul ((f32,-.ls)af_create_array x),((f32,-.rs)af_create_array y),ls,rs
)

NB. https://arrayfire.org/docs/matrixmanipulation.htm
qgridxy=: 3 : 0
freeall''
s=. af_create_array_jaf_ seq_jaf_ 1,y,1 NB. tile(seq(1,y),1,y)
a=. af_tile_jaf_ s;1;y;1;1              NB. tile(seq(1,y),1,y)
af_transpose_inplace_jaf_ a,0
c=. af_flat_jaf_ a
d=. af_tile_jaf_ s;y;1;1;1
e=. af_join_jaf_ 1;d;c
get_jaf_ e
)
