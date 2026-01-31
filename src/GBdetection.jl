# ---------------------------------------------- Input:
# G                                              Vector{QQMPolyRingElem}
# R                                              QQMPolyRing
# w                                              Vector{Int64}
# ---------------------------------------------- Output:
# true if G is GB w.r.t. w, false otherwise      Bool  
function BuchbergerCriterion(G::Vector{QQMPolyRingElem}, R::QQMPolyRing, w::Vector{Int})   
    all(reducedSpairs(G, R, w)) do x
        x == zero(R)
    end
end


# ------------------- Input:
# G                   Vector{QQMPolyRingElem}
# R                   QQMPolyRing
# ------------------- Output:
# list of weights     Vector{Vector{ZZRingElem}}  

function weightVectorsRealizingGB(G::Vector{QQMPolyRingElem}, R::QQMPolyRing; printWeights = false, returnOne = false)
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
                if (BuchbergerCriterion(G, R, -Int.(w)))
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