#include <arrayfire.h>
// create sparse array from dense identity array
//! af_release_array of sparse array does not free memory
int main(void)
{
 af_array af,saf;int ndims = 2; dim_t dims[] = {3,3}; size_t a,b,c,d;

 af_identity(&af,ndims,dims,f64);

 af_create_sparse_array_from_dense(&saf,af,AF_STORAGE_CSR);
 af_print_array(saf);
 
 af_release_array(af);
 af_device_gc();
 
 af_device_mem_info(&a,&b,&c,&d);
 printf("mem_info: %lu %lu %lu %lu \n",a,b,c,d);
 
 af_release_array(saf); // runs, but the memory is not released
 af_device_gc(); 
 
 af_device_mem_info(&a,&b,&c,&d);
 printf("mem_info: %lu %lu %lu %lu \n",a,b,c,d);
 
 return 0;
 }
