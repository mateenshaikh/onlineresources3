#include <Rcpp.h>
using namespace Rcpp;

//[[Rcpp::export]]
double getroot_cpp() {
  double x=0.0;
  double ee=0.0;
  for(int i=0;i<50000;i++){
    ee=exp(x);
    x=x-(ee+sin(x))/(ee+cos(x));
  }
  return (x);
}
