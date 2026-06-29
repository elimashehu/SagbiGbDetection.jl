```@meta
CurrentModule = SagbiGbDetection
```

# SagbiGbDetection Examples

These examples use Oscar.jl polynomial rings and the algorithms from
*SAGBI and Groebner Bases Detection*.

```julia
using Oscar
using SagbiGbDetection
```

## Groebner Basis Detection

`weightVectorsRealizingGB(G, R)` returns representative weights for
which `G` is a Groebner basis of its ideal.

```julia
R, (x, y, z) = polynomial_ring(QQ, ["x", "y", "z"])
G = [
    x^5 + y^3 + z^2 - 1,
    x^2 + y^2 + z - 1,
    x^6 + y^5 + z^3 - 1,
]

weightVectorsRealizingGB(G, R)
# [[12, 15, 27]]
```

An empty list means that no tested term order makes the generators a
Groebner basis.

```julia
S, (u, v) = polynomial_ring(QQ, ["u", "v"])
H = [u^2 + v^2 - 1, 2*u*v - 1]

weightVectorsRealizingGB(H, S)
# []
```

For a fixed weight vector, use `BuchbergerCriterion`.

```julia
BuchbergerCriterion(G, R, [12, 15, 27])
# true
```

## SAGBI Basis Detection

`weightVectorsRealizingSAGBI(F, R)` returns representative weights for
which `F` is a SAGBI basis of the subalgebra `R[F]`. The default
verification method, `method = :hilbert_series`, uses the criterion
from Lemma 3.7 and Remark 3.9 of the paper. Theorem 2.0.4 can be checked
with `method = :initial_ideal`. The aliases `:hilbert` and `:initial`
are also accepted.

```julia
R, (x, y, z) = polynomial_ring(QQ, ["x", "y", "z"])
F = [x + y + z, x*y + x*z + y*z, x*y*z]

weightVectorsRealizingSAGBI(F, R)
# 6 weight vectors, one for each permutation of [1, 2, 3]
```

For a fixed weight vector, use `SagbiCriterion`.

```julia
SagbiCriterion(F, R, [3, 2, 1])
# true

SagbiCriterion(F, R, [3, 2, 1]; method = :hilbert)
# true

SagbiCriterion(F, R, [3, 2, 1]; method = :initial_ideal)
# true
```

An empty list means that no tested term order makes the generators a
SAGBI basis.

```julia
S, (u, v) = polynomial_ring(QQ, ["u", "v"])
H = [u + v, u*v, u*v^2]

weightVectorsRealizingSAGBI(H, S)
# []
```

## Weight Representatives

`extractWeightVectors(F)` gives the representative weights coming from
the relevant normal cones of the Newton polytope.

```julia
extractWeightVectors(F)
```
