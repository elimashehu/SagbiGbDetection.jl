
# ---------------------------------------------- Input:
# G                                              Vector{QQMPolyRingElem}
# R                                              QQMPolyRing
# w                                              Vector{Int64}
# ---------------------------------------------- Output:
# true if G is SAGBI w.r.t. w, false otherwise   Bool           

function SagbiCriterion(G::Vector{QQMPolyRingElem}, R::QQMPolyRing, w::Vector{Int})
    
    n = length(G)
    ord = wdeglex(R, w)
    
    lt_G = [Oscar.leading_term(G[i], ordering = ord) for i in 1:n]
    
    S, vars = Oscar.polynomial_ring(Oscar.QQ, "z".*string.(1:n))
    g = hom(S, R, lt_G)
    h = hom(S, R, G)
    IA = kernel(g)
    I = kernel(h)

    H = homogenizer(S, "h")
    homI = H(I)
    homIA = H(IA)

    gradS = base_ring(homI)

    S1, _ = quo(gradS, homIA)
    S2, _ = quo(gradS, homI)

    return (string(Oscar.hilbert_series(S1)) == string(Oscar.hilbert_series(S2)))
end


# ------------------- Input:
# G                   Vector{QQMPolyRingElem}
# R                   QQMPolyRing
# ------------------- Output:
# list of weights     Vector{Vector{ZZRingElem}}  

function weightVectorsRealizingSAGBI(G::Vector{QQMPolyRingElem}, R::QQMPolyRing; printWeights = false, returnOne = false)
    P = Oscar.newton_polytope(reduce(*, G))
    V = Oscar.vertices(P)

    normalCones = maximal_cones(normal_fan(P))

    n = length(V[1])
    id = Oscar.identity_matrix(Oscar.ZZ, n)     
    NonnegativeOrth = Oscar.positive_hull(-id)

    res = []
    for c in normalCones
        intersectedC = Oscar.intersect(c,  NonnegativeOrth)
        if Oscar.dim(intersectedC) > 0
            rays = matrix(Oscar.ZZ, Oscar.rays(intersectedC))
            w = ones(Int, size(rays)[1])*rays
            
            if (all(wi -> wi < 0, w)) 
                if (SagbiCriterion(G, R, -Int.(w)))
                    if returnOne
                        return -Int.(w)
                    end
                    if printWeights
                        println(-Int.(w))
                    end
                    push!(res, -Int.(w))
                end
            end
        end
    end
    
    return(res)
end