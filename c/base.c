#include <arrayfire.h>
// Generate random data and sum and print the result
int main(void)
{
 af_array w,r,a;
 int       wndims = 2;
 dim_t     wdims[] = {2,3};
 long long wdata[]= {0,1,2,3,4,5};
 af_create_array(&w,wdata,wndims,wdims,s64);
 af_print_array(w);
 
 af_sum(&r,w,0);
 af_print_array(r);
 af_sum(&r,w,1);
 af_print_array(r);
 
 
 


    // generate random values
    af_randu(&a, wndims, wdims, f64);
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
    
    
    //AFAPI af_seq af_make_seq(10,20,2);
    af_seq sq= af_make_seq(10,20,2);
    printf("sq.begin: %g\n", sq.begin);
    printf("sq.end:   %g\n", sq.end);
    printf("sq.step:  %g\n", sq.step);
    

//    dim_t cdims[] = {1,1};
//    af_constant(&a,123,2,cdims,s64);
 //   af_print_array(a);

 //   int buf[]={666};
 //   a(1,buf);
 //   af_print_array(a);



    return 0;
}
