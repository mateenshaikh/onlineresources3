---
title: test julia thing
author: ''
date: '2021-06-18'
slug: []
categories: []
tags: []
weight: 5
---



## newton method

This documents the timings of a simple newton method in R, C (technically cpp but it's all just C code), and julia.

### the function used
The function is `\(f_0(x)=e^x+\sin(x)\)` so the newton update would be
`$$x\leftarrow x-\frac{f_0(x)}{f_1(x)}=x-\frac{e^x+sin(x)}{e^x+cos(x)}$$`

applied repeatedly. A graph of the curve is shown below. It's already fairly linear so the function will hit the root very quickly but that's ok. 




```r
curve(exp(x)+sin(x),-1,0)
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-1-1.png" width="672" />

## the code

We'll run the code a fixed number of iterations. I don't know if hitting 0 in the numerator does any short-cutting in any language but thats ok for now.

Note that the julia code will be called within r (just like the rcpp is). For completeness the pure julia code is <a href="#rawjulia"> in the raw julia code </a>.


{{< codes r cpp julia >}}
  {{< code >}}

```r
getroot_r=function(){
  x=0.0
  ee=0
  for (i in 1:50000){
    ee=exp(x)
    x=x-(ee+sin(x))/(ee+cos(x))
  }
  return (x);
}
```
{{< /code >}}


{{< code >}}

```cpp
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
```
{{< /code >}}
{{< code >}}

```r
library(JuliaCall)
julia_command("f0(x)=exp(x)+sin(x)")
```

```
## Julia version 1.6.0 at location /opt/julia-1.6.0/bin will be used.
```

```
## Loading setup script for JuliaCall...
```

```
## Finish loading setup script for JuliaCall.
```

```
## f0 (generic function with 1 method)
```

```r
julia_command("f1(x)=exp(x)+cos(x)")
```

```
## f1 (generic function with 1 method)
```

```r
julia_command("update(x)=x-f0(x)/f1(x)")
```

```
## update (generic function with 1 method)
```

```r
julia_command("function getroot_julia()
    x=0.0
    for i in 1:50000
        x=update(x)
    end
    return x
end")
```

```
## getroot_julia (generic function with 1 method)
```

{{< /code >}}
{{< /codes >}}





## results

Now that all the functions are created and available, they're assessed in R. Each runs the same number of iterations with the same initial guess. Each language's implementation is run a few times times.





```r
library(microbenchmark)
results = microbenchmark(getroot_r(),getroot_cpp(),julia_eval("getroot_julia()"),times=5)
```


{{< codes boxplot-base-r violinplot-ggplot2>}}
  {{< code >}}
  
  ```r
  languages = c("R","cpp","julia")
  boxplot(results,names=languages)
  ```
  
  <img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-6-1.png" width="672" />
    {{< /code >}}

  {{< code >}}
  
  ```r
  library(ggplot2)
  languages = c("R","cpp","julia")
  df=results
  df$expr=languages
  autoplot(df)
  ```
  
  <img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-7-1.png" width="672" />
  {{< /code >}}
{{< /codes >}}


  
  ```r
  print(results)
  ```
  
  ```
  ## Unit: milliseconds
  ##                           expr      min       lq      mean   median       uq
  ##                    getroot_r() 7.936465 8.000910 10.843673 8.139050 8.404150
  ##                  getroot_cpp() 1.707158 1.711611  1.895882 1.719499 1.964071
  ##  julia_eval("getroot_julia()") 1.172063 1.202188 24.513607 1.302336 1.501026
  ##        max neval
  ##   21.73779     5
  ##    2.37707     5
  ##  117.39042     5
  ```
  
  ```r
  medians = summary(results)[,"median"]
  names(medians)=languages
  
  #speeds relative to r
  medians/max(medians)
  ```
  
  ```
  ##         R       cpp     julia 
  ## 1.0000000 0.2112653 0.1600108
  ```
  
  ```r
  #speeds relative to julia
  medians/min(medians)
  ```
  
  ```
  ##        R      cpp    julia 
  ## 6.249578 1.320319 1.000000
  ```
  



## the raw julia code {#rawjulia}
The raw julia is shown below. These lines are actually run in julia but at the end we'll call it from R, so the code will be revisted at the end.


```julia
f0(x)=exp(x)+sin(x)
```

```
## f0 (generic function with 1 method)
```

```julia
f1(x)=exp(x)+cos(x)
```

```
## f1 (generic function with 1 method)
```

```julia
update(x)=x-f0(x)/f1(x)
```

```
## update (generic function with 1 method)
```

```julia
function getroot_julia()
  x=0.0
    for i in 1:50000
        x=update(x)
    end
    return x
end
```

```
## getroot_julia (generic function with 1 method)
```

```julia


using BenchmarkTools
timing_julia = @benchmark getroot_julia() samples=5 evals=5
```

```
## BenchmarkTools.Trial: 
##   memory estimate:  0 bytes
##   allocs estimate:  0
##   --------------
##   minimum time:     1.021 ms (0.00% GC)
##   median time:      1.033 ms (0.00% GC)
##   mean time:        1.036 ms (0.00% GC)
##   maximum time:     1.071 ms (0.00% GC)
##   --------------
##   samples:          5
##   evals/sample:     5
```

```julia
print(timing_julia)
```

```
## Trial(1.021 ms)
```
