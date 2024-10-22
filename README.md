
# SagbiGbDetection.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://elimashehu.github.io/SagbiGbDetection.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://elimashehu.github.io/SagbiGbDetection.jl/dev/)
[![Build Status](https://github.com/elimashehu/SagbiGbDetection.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/elimashehu/SagbiGbDetection.jl/actions/workflows/CI.yml?query=branch%3Amain)


A julia package for finding the term order for which the given generators of an ideal form the Gröbner basis or the given generators of a finitely generated subalgebra of a polynomial ring are the SAGBI basis. If there is no such term order, then the given set of generators of an ideal or subalgebra is not a Gröbner basis or SAGBI basis respectively for any term order. 


For more information on the algorithm, please refer to the following reference.

> [Viktoriia Borovik, Timothy Duff, Elima Shehu, "SAGBI and Gröbner Bases Detection](https://arxiv.org/abs/2404.16796)


## 🛠️ Installation
SagbiGbDetection requires Julia 1.8 or newer. In principle it can be installed and used
like any other Julia package:

```julia
julia> ]add SagbiGbDetection
```

or

```julia
julia> using Pkg
julia> Pkg.add(url="https://github.com/elimashehu/SagbiGbDetection.jl")
```

## Documentation and Examples

You can find a detailed documentation including various examples at 👉
[documentation](https://elimashehu.github.io/SagbiGbDetection.jl/dev/)


## 👷 Development team

- Viktoriia Borovik  <vborovik@uni-osnabrueck.de>
- Timothy Duff <timduff@uw.edu>
- Elima Shehu <elima.shehu@mis.mpg.de>
