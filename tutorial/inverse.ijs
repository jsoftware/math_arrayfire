freeall_jaf_'' NB. release all AF arrays and do device garbage collection

afinv=. 3 : 0
af=. af_create_array_jaf_ y
raf=. af_inverse_jaf_ af
get_jaf_ raf
)

a=. 0.0+?.500 500 $ 1000

timex 'ja=. %.a'
timex 'afa=. afinv a'

>./,|ja-afa NB. very close, but not exact

freeall_jaf_'' NB. release all AF arrays and do device garbage collection