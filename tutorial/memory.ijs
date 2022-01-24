NB. memory management tests

release_jaf_ AFS_jaf_ NB. release all af_arrays
assert 0=#AFS_jaf_

af_device_gc_jaf_'' NB. garbage collect
assert 0=af_device_mem_info_jaf_''

ai=. af_create_array_jaf_ jai=. ?4 4$100
[af_device_mem_info_jaf_''

release_jaf_ AFS_jaf_ NB. release all af_arrays
[af_device_mem_info_jaf_''
af_device_gc_jaf_'' NB. garbage collect
assert 0=af_device_mem_info_jaf_''

