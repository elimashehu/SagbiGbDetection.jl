function Spair(R::QQMPolyRing, f::QQMPolyRingElem, g::QQMPolyRingElem, w::Vector{Int}) 
    ord = wdeglex(R, w)
    lt_f = leading_term(f, ordering = ord) 
    lt_g = leading_term(g, ordering = ord)
    lcm_lt = lcm(lt_f, lt_g)
    return  divexact(lcm_lt, lt_f)*f - divexact(lcm_lt, lt_g)*g
end

function division(f::QQMPolyRingElem, G::Vector{QQMPolyRingElem}, R::QQMPolyRing, w::Vector{Int}) 
    m = length(G)
    ord = wdeglex(R, w)
    quotients = Dict([(j, zero(f)) for j in 1:m])
    remainder = f

    while remainder != 0
        divided = false

        for i in 1:m
            if divrem(leading_term(remainder, ordering = ord), leading_term(G[i], ordering = ord))[2] == 0
                q, _ = divrem(leading_term(remainder, ordering = ord), leading_term(G[i], ordering = ord))
                quotients[i] += q
                remainder -= q * G[i]
                divided = true
                break
            end
        end

        if !divided
            break
        end
    end
    return remainder
end

function reducedSpairs(G::Vector{QQMPolyRingElem}, R::QQMPolyRing, w::Vector{Int})   
    n = length(G)
    return [division(Spair(R, G[i], G[j], w), G, R, w) for i in 1:n for j in (i+1):n]
end


# -------------  Input:
# G              Vector{QQMPolyRingElem}
# -------------  Output:
# list of weights 
# from normal fan of the affine 
# newton polyhedron    
function extractWeightVectors(G::Vector{QQMPolyRingElem})
    P = Oscar.newton_polytope(reduce(*, G))
    V = Oscar.vertices(P)
    
    normalCones = [Oscar.normal_cone(P, i) for i in 1:length(V)]
    
    n = length(V[1])
    id = Oscar.identity_matrix(Oscar.ZZ, n)     
    NonnegativeOrth = Oscar.positive_hull(-id)
    intersectedNormalCones = [Oscar.intersect(c,  NonnegativeOrth) for c in normalCones]
    
    goodCones = [c for c in intersectedNormalCones if dim(c) > 0]
    ray_s = [matrix(Oscar.ZZ, Oscar.rays(c)) for c in goodCones]
    ray_sum = [ones(Int, size(ray_s[i])[1])*ray_s[i] for i in 1:length(ray_s)] 
    
    return filter(w -> all(wi -> wi < 0, w), ray_sum)
end