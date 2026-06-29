```@meta
CurrentModule = SagbiGbDetection
```

# SagbiGbDetection

[SagbiGbDetection.jl](https://github.com/elimashehu/SagbiGbDetection.jl)
is a Julia package for Gröbner and SAGBI basis detection.

```@index
```


# Getting Started

SagbiGbDetection is a computer algebra package for the Julia programming
language, maintained by Viktoriia Borovik, Timothy Duff and Elima Shehu.

- <https://github.com/elimashehu/SagbiGbDetection.jl> (Source code)

SagbiGbDetection implements algorithms for detecting whether a given set
of polynomials forms a Groebner basis or SAGBI basis with respect to some
term order. The implementation uses Oscar.jl.


### Installation

Install Julia from <https://julialang.org/downloads/>.

SagbiGbDetection requires Julia 1.8 or newer. Once the package is
registered, install it with:

```julia
julia> ]add SagbiGbDetection
```

Until registration is complete, install the development version from
GitHub:

```julia
julia> using Pkg
julia> Pkg.add(url = "https://github.com/elimashehu/SagbiGbDetection.jl")
```

### Examples

The [examples](@ref SagbiGbDetection-Examples) page covers the main
Groebner and SAGBI routines. The [application examples](@ref Application-Examples)
page gives Julia code for examples from the paper.
