NB. indexing with seq - span is special seq with 1 1 0

freeall_jaf_'' NB. release all AF arrays and do device garbage collection

afai=. af_create_array_jaf_ i.23
get_jaf_          afai

res=. af_index_jaf_ afai;1;0 22 3
get_jaf_   res


s1=. 0 5 3
s2=. 0 7 2
arg=. af_create_array_jaf_ i.10 10
res=. af_index_jaf_ arg;2;s1,s2
[a=. get_jaf_   res

[b=. (seq_jaf_ s2){"1 (seq_jaf_ s1){i.10 10
assert a-:b


s2=. 1 1 0 NB. span
res=. af_index_jaf_ arg;2;s1,s2
[a=. get_jaf_   res

assert a-:(seq_jaf_ s1){i.10 10


freeall_jaf_'' NB. release all AF arrays and do device garbage collection
