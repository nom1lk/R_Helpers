Understanding functions in R
================

Functions will only print the last line of output

``` r
ftest <- function() {
  2 * 2
}
ftest()
```

    ## [1] 4

\[1\] 4
=======

ftest &lt;- function() { 2 \* 2 3 \* 3 } ftest() \# \[1\] 9

If we call a function that operates on some variable, then the variable must be available.
==========================================================================================

The function will first check it's local environment before checking the global environment
===========================================================================================

ftest &lt;- function() { y &lt;- 2.3 y \* 2 } ftest() \# \[1\] 4.6

y &lt;- 5 x &lt;- 22

We tell the function we will not be providing it anything (specifically, no y variable), so it looks for the y variable in the global environment
=================================================================================================================================================

ftest &lt;- function() { y \* 2 } ftest() \# \[1\] 10

If we call the same function but y is not available in the global environment, it errors
========================================================================================

rm(y) ftest() \# Error in ftest() : object 'y' not found

If we tell a function we will provide it some argument(s), then we must do so (it's not enough that something of the same name as the argument is available globally)
=====================================================================================================================================================================

ftest &lt;- function(y) { y \* 2 } ftest() \# Error in ftest() : argument "y" is missing, with no default

ftest &lt;- function() { z \* 2 } ftest()

However, lazy evaluation should have meant this wouldn't error
==============================================================

ftest &lt;- function(y, x) { y \* 2 } ftest()

Here we
=======

ftest &lt;- function(y) { y \* 2 } ftest(2) \# \[1\] 4

----- Understanding error: "promise already under evaluation: recursive default argument reference or earlier problems?" -----
==============================================================================================================================

<https://stackoverflow.com/questions/8425348/unexpected-behaviour-with-argument-defaults>
=========================================================================================

It seems if R sees a value of an argument
=========================================

y &lt;- 5

f knows what x is because y is defined in the global environment
================================================================

f &lt;- function(x=y) x^2 f() \# Works fine

f2
==

f2 &lt;- function(y=y) y^2 f2() \# Errors

Here we can see that the inner\_function can access the arguments that were provided to the outer\_function,
============================================================================================================

Which makes sense, since functions can access objects from the global environment
=================================================================================

Possible lesson: environments can access all the variables from their ancestors
===============================================================================

outer\_function &lt;- function(x, y, ...) {

inner\_function &lt;- function(x=x, y=y) {

    print(x)
    print(y)


    args <- list(...)
    print(args)
    print(args[[1]])
    print(args[[2]])

}

inner\_function()

}

outer\_function("hi", "bye", "here", "now")

HelloWorld &lt;- function(...) { arguments &lt;- list(...) paste(arguments) arguments\[\[1\]\] %&gt;% print(.) arguments\[\[2\]\] %&gt;% print(.) }

HelloWorld("Hello", "World", "!")

HelloWorld &lt;- function(x, ...) { arguments &lt;- list(...) paste(arguments) arguments\[\[1\]\] %&gt;% print(.) arguments\[\[2\]\] %&gt;% print(.) }

HelloWorld("Hello", "World", "!")

HelloWorld &lt;- function(x, ...) { arguments &lt;- list(...) paste(arguments) x %&gt;% print(.) arguments\[\[1\]\] %&gt;% print(.) arguments\[\[2\]\] %&gt;% print(.) }

HelloWorld("Hello", "World", "!")

HelloWorld &lt;- function(x, ...) { arguments &lt;- list(...) paste(arguments) x %&gt;% print(.) arguments\[\[1\]\] %&gt;% print(.) arguments\[\[2\]\] %&gt;% print(.)

HelloWorld2 &lt;- function(...) {

arguments2 &lt;- list(...) temp &lt;- arguments2\[\[1\]\] %&gt;% paste0(", it works!!") return(temp) }

temp &lt;- HelloWorld2(x) \# Don't forget to assign what is returned by the inner function, or else you don't be able to access it

print(temp)

}

Note in both cases, "world" and "!" are allowed in by the ... (variable number of arguments)
============================================================================================

HelloWorld("Hello", "World", "!") HelloWorld(x = "Hello", "world", "!")

This works
==========

outer\_function &lt;- function(x) { inner\_function &lt;- function(x) {

    return(paste0(x, ", it worked!"))

}

output\_from\_inner\_function &lt;- inner\_function(x) print(output\_from\_inner\_function) } outer\_function("hi")

outer\_function &lt;- function(x, ...) { args1 &lt;- list(...) inner\_function &lt;- function(x, args1) { args2 &lt;- list(...) print(paste(args2)) } }

outer\_function("hi", "bye")

Can we somehow print the contents of the inner function?
========================================================

ANS: Yes, just store the output (or assigned variables) available and print them
================================================================================

outer\_function &lt;- function() { inner\_function &lt;- function() { "hi" } toprint &lt;- inner\_function() print(toprint) } outer\_function()

----- Example 1 -----
=====================

calling an object's name in a function is no different to doing so normally, that is,
=====================================================================================

it will simply return that object's value
=========================================

fun &lt;- function(x) { x } fun("hi") \# \[1\] "hi"

----- Example 2 -----
=====================

Function calls inside a function will return the same output as though that code had been called normally within the outer function
===================================================================================================================================

BUT it will only return the *last line* of that output - why? I'm not sure! But if you want more than just the last line, assign to a list and return it!
=========================================================================================================================================================

outer\_function &lt;- function() {

inner\_function &lt;- function() { "hi" parent.frame() }

inner\_function() }

outer\_function()

----- Notes -----
=================

globalenv() globalenv() %&gt;% parent.env \# The parent environment of the global environment is the last package opened (who knows why?) - unless no packages are open in which case it doesn't have a parent env globalenv() %&gt;% parent.env %&gt;% parent.env

---- Create a nested environment -----
======================================

From: <https://stackoverflow.com/questions/10904124/global-and-local-variables-in-r>
====================================================================================

test.env &lt;- new.env()

assign('abcd', 100, envir=test.env) \# or simply test.env$abcd &lt;- 100

get('abcd') \# abcd cannot be found since it is not defined in this environment get('abcd', envir=test.env) \# now it can be found

----- Observe the objects inside an environment -----
=====================================================

From here: <https://stackoverflow.com/questions/8142941/how-to-search-an-environment-using-ls-inside-a-function>
================================================================================================================

QQQ why .GlobalEnv below? rather than R\_GlobalEnv, that is, the output from parent.frame() ?
=============================================================================================

x &lt;- 1:10 f &lt;- function() ls() g &lt;- function() ls(envir=.GlobalEnv) h &lt;- function() ls(envir=.GlobalEnv, pattern="\[fg\]") f() \# character(0) g() \# \[1\] "f" "g" "h" "x" h() \# \[1\] "f" "g"

f &lt;- function() { output &lt;- list() output\[\[1\]\] &lt;- ls() output\[\[2\]\] &lt;- parent.frame() return(output) }

f()

f &lt;- function() { parent.frame() } f()

Four special environments
=========================

globalenv() \# Environment in which you normally work baseenv() \# Base environment emptyenv() \# The ultimate ancestor of all environments environment() \# Returns the current environment identical(globalenv(), environment()) \# \[1\] TRUE - which makes sense

search() \# lists all parents of the global environment
