NB. device memory management tutorial and test

0 : 0
device memory for af_arrays is generally transient
 typically it is created, used, J gets J array results
  and then there is a freeall
  
do freeall before starting new work so the slate is clean
 af_arrays will still be around if needed, before the next freeall
 
you can hold an af_array so that a freeall won't free it
)

freeall_jaf_ ''         NB. free all af_arrays and do gc
assert 0=#AFS_jaf_

[t=. af_device_mem_info_jaf_'' NB. bytes,objects,lockbytes,lockobjects
ai=. af_create_array_jaf_ jai=. ?4 4$100
[af_device_mem_info_jaf_'' NB. increase of 1 object

freeall_jaf_''
assert t=af_device_mem_info_jaf_'' NB. should be what it was

ai=. af_create_array_jaf_ jai=. ?4 4$100
get_jaf_ ai
hold_jaf_ ai NB. prevent release until it is letgo
[AFSHOLD_jaf_

free_jaf_ '' NB. free all except those that are held
get_jaf_ ai  NB. still there
letgo_jaf_ ai
free_jaf_ ''
AFS_jaf_     NB. all have been release

NB. free and freeall both do a garbage collection
af_device_gc_jaf_'' NB. explicit garbage collection

(0.6+i.2 2) qmp_jaf_ 0.5+i.2 2
AFS_jaf_
get_jaf_ _1{AFS_jaf_ NB. still there

'assertion failure'-:(i.2 2) qmp_jaf_ etx i.2 2 NB. error - int not supported
13!:12''
LASTERROR_jaf_

freeall_jaf_''  NB. not all memory has been freed
chkleak_jaf_'' 

