---
date: "2020-01-28T00:36:19+09:00"
description: test post
draft: false
title: Math
---

Within a markdown document, if you wish to enter simple math, just use code as if you were writing LaTeX code, so you can directly write 


```latex
The equation `\(y=\alpha^2\)` is a quadratic.
```
or 
```latex
The equation `$y=\alpha^2$` is quadratic.
```
for inline equations and

```latex
The equation \[y=\alpha^2\] is quadratic.
```
or 
```latex
is quadratic. $$y=\alpha^2$$ is quadratic.
```

for standalone environments. They will render as :



The equation `$y=\alpha^2$` is quadratic.

for inline or 


   The equation $$y=\alpha^2$$ is quadratic.



As a quirk foyou probably noticed, inline markdown requires the code to be written in back ticks \`\$y=\alpha^2\$\`. It works for standalone equation environments too, so you can use the backticks all the time. Alternatively, if you're like me, and write a lot of the documents in `Rmarkdown` because you put coding in the document too, then you don't need the backticks at all (but they will work).


More sophisticated things that require non-standard libraries will require a bit of work to get, so don't go overboard. It is still HTML in the end, afterall. The good news is you can google what it is you want, if it's common enough there's likely a solution. The bad news is it may look ugly but only a copy-paste away.
