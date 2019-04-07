# EnvelopedArrays

[![Build Status](https://travis-ci.org/tbeason/EnvelopedArrays.jl.svg?branch=master)](https://travis-ci.org/tbeason/EnvelopedArrays.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/tbeason/EnvelopedArrays.jl?svg=true)](https://ci.appveyor.com/project/tbeason/EnvelopedArrays-jl)
[![CodeCov](https://codecov.io/gh/tbeason/EnvelopedArrays.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/tbeason/EnvelopedArrays.jl)

I built this because I was doing `vcat(::Number,::AbstractArray)` an insane amount of times in my code. That operation requires a copy of the data, this package sidesteps that unnecessary allocation.

In terms of usability, in the example below `x_env` should match `x_vcat` in behavior.
```julia
a = rand(5,5)
x_vcat = vcat(0.0,a)
x_env = EnvelopedArray(0.0,a)
```


EnvelopedArrays are immutable, but creating a new instance is quick. So, if you wanted to change the parent array in `x_env` (from above) from `a` to `a2` , you can just do `x_env = EnvelopedArray(0.0,a2)`. Doing it this way just creates a reference, there is no copying of the underlying array.



### Thanks

Thanks to the helpful people on Julia Slack for answering my questions. Additional feedback or suggested improvements are welcome!