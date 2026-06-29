
# SagbiGbDetection.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://elimashehu.github.io/SagbiGbDetection.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://elimashehu.github.io/SagbiGbDetection.jl/dev/)
[![Build Status](https://github.com/elimashehu/SagbiGbDetection.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/elimashehu/SagbiGbDetection.jl/actions/workflows/CI.yml?query=branch%3Amain)


SagbiGbDetection.jl finds term orders for which a given set of
polynomials is a Gröbner basis of the ideal it generates, or a SAGBI
basis of the subalgebra it generates. An empty output means that no
candidate term order passed the corresponding criterion.

The package is implemented in Julia and uses Oscar.jl.


The algorithms are described in:

> [Viktoriia Borovik, Timothy Duff, Elima Shehu, "SAGBI and Gröbner Bases Detection"](https://arxiv.org/abs/2404.16796)


## Installation

SagbiGbDetection requires Julia 1.8 or newer. Once the package is
registered, install it with:

```julia
julia> ]add SagbiGbDetection
```

Until then, install the development version from GitHub:

```julia
julia> using Pkg
julia> Pkg.add(url = "https://github.com/elimashehu/SagbiGbDetection.jl")
```

## Documentation and Examples

The documentation is available at
[elimashehu.github.io/SagbiGbDetection.jl](https://elimashehu.github.io/SagbiGbDetection.jl/dev/).

```julia
using Oscar
using SagbiGbDetection

R, (x, y, z) = polynomial_ring(QQ, ["x", "y", "z"])
G = [x^5 + y^3 + z^2 - 1, x^2 + y^2 + z - 1, x^6 + y^5 + z^3 - 1]

weightVectorsRealizingGB(G, R)
# [[12, 15, 27]]
```

By default, SAGBI verification uses the Hilbert-series criterion from
the paper. The criterion from Theorem 2.0.4 is available with
`method = :initial_ideal`. The aliases `:hilbert` and `:initial` are
also accepted:

```julia
F = [x + y + z, x*y + x*z + y*z, x*y*z]
SagbiCriterion(F, R, [3, 2, 1]; method = :initial_ideal)
# true
```


## Development team

- Viktoriia Borovik  <viktoriia.borovik@mis.mpg.de>
- Timothy Duff <tduff@missouri.edu>
- Elima Shehu <elima.shehu@ovgu.de>
