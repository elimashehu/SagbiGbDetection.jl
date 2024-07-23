```@meta
CurrentModule = SagbiGbDetection
```

# SagbiGbDetection

Documentation for [SagbiGbDetection](https://github.com/elimashehu/SagbiGbDetection.jl).

```@index
```


# Getting Started

SagbiGbDetection is a computer algebra package for the Julia programming 
language, maintained by Viktoriia Borovik, Tim Duff and Elima Shehu.

- <https://github.com/elimashehu/SagbiGbDetection.jl> (Source code)

The features of SagbiGbDetection include algorithms for detecting if
a given set of polynomials form a Gröbner bases or SAGBI basis respectively
with respect to some term order.


### Installation

Please see <https://julialang.org/downloads/> 
for instructions on how to obtain julia for your system.

SagbiGbDetection requires Julia 1.8 or newer. In principle it can be installed and used
like any other Julia package:

```julia
julia> ]add SagbiGbDetection
```

or

```julia
julia> using Pkg
julia> Pkg.add("SagbiGbDetection")
```