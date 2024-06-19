```@meta
CurrentModule = SagbiGbDetection
```
# SagbiGbDetection

Documentation for [SagbiGbDetection](https://github.com/zavala92/SagbiGbDetection.jl).

```@index
```

```@contents
Pages = ["SagbiGBDetection_examples.md"]
```

# Gröbner Basis Detection


## Introduction

SagbiGbDetection allows to compute the term order for which the given generators of an ideal form the Gröbner basis. 


## Functionality

The first main functionality of this package includes ```weightVectorsRealizingGB(G, R)```. A function for extracting the weight vectors for which the given set of polynomials is a Gröbner basis.

Given a set of polynomials (G) and a polynomial ring (R) as input, the function produces an array of weight vectors for which the provided set of polynomials adheres to the Buchberger Criterion. It also yields a Boolean value, which is 'True' when the set of polynomials constitutes a Gröbner basis for all weight vectors, and 'False' when it does not.
  
```
using SagbiGbDetection
```

```
julia> R, (x, y) = Singular.polynomial_ring(Singular.QQ, ["x","y"])
(Singular Polynomial Ring (QQ),(x,y),(dp(2),C), spoly{n_Q}[x, y])

julia> G = [y^2-x, x^2-1]
2-element Vector{spoly{n_Q}}:
 y^2 - x
 x^2 - 1

```

```
julia> weightVectorsRealizingGB(G, R)
(Vector{ZZRingElem}[[2, 2]], false)
```

```@docs
weightVectorsRealizingGB(G, R) 
```


# Extract Weight Vectors

To define different term orders, the function ```extractWeightVectors(G)``` computes the Newton polytope of the set of given generators ```G``` and for each vertex of the polytope, it decides if the normal cone to this vertex intersects the positive orthant. If this happens then it selects a weight w in the intersection which serves as a term order in the detection algorithms.

```
julia> extractWeightVectors(G)
2-element Vector{Vector{ZZRingElem}}:
 [-2, -2]
 [-3, -1]
```

# S-polynomial

Given two polynomials f and g the function ```Spair(f, g)``` computes the S-polynomial. 

```
julia> Spair(G[1], G[2])
-x^3 + y^2
```
# Buchberger Criterion and SAGBI criterion

Given a set of polynomials GS in a ring R, the function ```BuchbergerCriterion(GS, R)```  is for checking the Buchberger criterion for the set of polynomials GS.

```
julia> BuchbergerCriterion(G,R)
true
```
Similarly, ```SagbiCriterion(G, R, w::Vector{Int})``` is a function for checking if a set of polynomials satisfies the SAGBI criterion.

# SAGBI Basis Detection


## Introduction

SagbiGbDetection allows to compute the term order for which the given generators of a finitely generated subalgebra of a polynomial ring are the SAGBI basis. 

## Functionality

The second main functionality of this package includes ```weightVectorsRealizingSAGBI(G, R)```. A function that identifies weight vectors that meet the SAGBI criterion for a specified set of polynomials.

Given a set of polynomials (G) and a polynomial ring (R) as input, the function provides an array of weight vectors that satisfy the SAGBI criterion, along with a Boolean value indicating whether the SAGBI criterion is met for all weight vectors, where 'True' signifies compliance and 'False' denotes non-compliance.

```@docs
weightVectorsRealizingSAGBI(G, R)
```

