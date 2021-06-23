---
date: "2020-01-28T00:36:19+09:00"
description: test post
draft: false
title: Code
---


## Regular code
The coolest thing (to me) about the [original zdoc theme](https://zzo-docs.vercel.app/zdoc/), is how the coding renders. A variety of common languages are included but not all of them. You can download more but it does bloat the site so only take the ones you think you'll need to use. If you want to use (any) code and show it you'll use the following template

    ```language
    line of code 1
    line of code 2
    line of code 3
    ```

if you specify a recognzied language, the appropriate syntax highlighting is used. For example

    ```r
    signSquare = function(x){
	return (sign(x) * x^2)
    }
    ```
will render as

```r
signSquare = function(x){
return (sign(x) * x^2)
}
```

The original theme was clever in showing the language that's used on the right side in a tab.

## code tabs

If, for some reason, you want to create in-page tabs to show code (for example, the same code but in different languages) you can use the tabs shortcut. A shortcode is something that neat about Hugo websites, that gives quite a bit of flexibility. The author of the original theme took care to write the `tabs` shortcode that works very well for code.

For example,


    {{ < tabs rcode juliacode >}}
    {{ <tab> }}
    ```r
    signSquare = function(x){
	return (sign(x) * x^2)
    }
    ```
    {{ </tab> }}
    {{ <tab> }}
    ```r
    signSquare = function(x){
	return (sign(x) * x^2)
    }
    {{ </tab> }}
    {{ <tabs> }}

renders as



{{<tabs rcode juliacode >}}
{{<tab>}}
```r
signSquare = function(x){
  return (sign(x) * x^2)
}
```
{{</tab>}}
{{<tab>}}
```julia
function signSquare(x)
  sign(x) * x^2
end
{{</tab>}}
{{<tabs>}}

If you're Rmarkdown environment, you'll want to make sure that you put braces around the language to execute the code (rather than just display it the way markdown does). Besides that, your approach is the same.


