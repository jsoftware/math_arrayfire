#include <arrayfire.h>
// Generate random data and sum and print the result
int main(void)
{
    // generate random values
    af_array a;
    int n_dims = 1;
    dim_t dims[] = {5};
    af_randu(&a, n_dims, dims, f64);
    af_print_array(a);
    // sum all the values
    double result;
    af_sum_all(&result, 0, a);
    printf("sum: %g\n", result);
    printf("dtype: %i\n", s64);
    printf("dtype: %i\n", f64);
    printf("af_mat_none: %i\n", AF_MAT_NONE);
    printf("zero: %i\n", 0);
    printf("cast zero: %i\n", (af_mat_prop)0);



    dim_t d2[]={4,4};
    af_array res,left,right;
    af_randu(&left , 2, d2, f64);
    af_randu(&right,  2, d2, f64);
    af_matmul(&res,left,right,AF_MAT_NONE,AF_MAT_NONE);
    //af_matmul(&res,left,right,(af_mat_prop)0,(af_mat_prop)0);
    //af_matmul(&res,left,right,0,0); // fails because enums are not ints! ugh
    af_print_array(res);


//    dim_t cdims[] = {1,1};
//    af_constant(&a,123,2,cdims,s64);
 //   af_print_array(a);

 //   int buf[]={666};
 //   a(1,buf);
 //   af_print_array(a);



    return 0;
}
