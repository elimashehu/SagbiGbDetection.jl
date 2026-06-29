const SAGBI_VERIFICATION_METHODS = (:hilbert_series, :hilbert, :initial_ideal, :initial)

function _sagbi_relation_data(G::Vector{QQMPolyRingElem}, R::QQMPolyRing, w::Vector{Int})
    n = length(G)
    ord = wdeglex(R, w)

    lt_G = [Oscar.leading_term(G[i], ordering = ord) for i in 1:n]
    relation_weights = [dot(Int.(exponent_vector(lt, 1)), w) for lt in lt_G]

    S, _ = Oscar.polynomial_ring(Oscar.QQ, "z".*string.(1:n))
    g = hom(S, R, lt_G)
    h = hom(S, R, G)

    return S, kernel(g), kernel(h), relation_weights
end

function _weighted_initial_form(f::QQMPolyRingElem, w::Vector{Int})
    iszero(f) && return f

    weighted_terms = collect(terms(f))
    degrees = [dot(Int.(exponent_vector(term, 1)), w) for term in weighted_terms]
    top_degree = maximum(degrees)

    result = zero(parent(f))
    for (term, degree) in zip(weighted_terms, degrees)
        if degree == top_degree
            result += term
        end
    end

    return result
end

function _sagbi_hilbert_series_criterion(G::Vector{QQMPolyRingElem}, R::QQMPolyRing, w::Vector{Int})
    S, IA, I, _ = _sagbi_relation_data(G, R, w)

    H = homogenizer(S, "h")
    homI = H(I)
    homIA = H(IA)

    gradS = base_ring(homI)

    S1, _ = quo(gradS, homIA)
    S2, _ = quo(gradS, homI)

    return string(Oscar.hilbert_series(S1)) == string(Oscar.hilbert_series(S2))
end

function _sagbi_initial_ideal_criterion(G::Vector{QQMPolyRingElem}, R::QQMPolyRing, w::Vector{Int})
    S, IA, I, relation_weights = _sagbi_relation_data(G, R, w)

    relation_ordering = wdeglex(S, relation_weights)
    relation_groebner_basis = standard_basis(I, ordering = relation_ordering)
    weighted_initial_generators = [
        _weighted_initial_form(f, relation_weights) for f in gens(relation_groebner_basis)
    ]

    return ideal(S, weighted_initial_generators) == IA
end

# Test the SAGBI property with either the Hilbert-series criterion or the
# weighted-initial-ideal criterion.
function SagbiCriterion(G::Vector{QQMPolyRingElem}, R::QQMPolyRing, w::Vector{Int}; method::Symbol = :hilbert_series)
    if method in (:hilbert_series, :hilbert)
        return _sagbi_hilbert_series_criterion(G, R, w)
    elseif method in (:initial_ideal, :initial)
        return _sagbi_initial_ideal_criterion(G, R, w)
    end

    throw(ArgumentError("Unsupported SAGBI verification method: $(method). Supported methods are :hilbert_series, :hilbert, :initial_ideal, and :initial."))
end

function SagbiCriterion(G::Vector{QQMPolyRingElem}, R::QQMPolyRing, w::Vector{<:Integer}; method::Symbol = :hilbert_series)
    return SagbiCriterion(G, R, Int.(w); method = method)
end


# Representatives of normal cones for which G is a SAGBI basis.
function weightVectorsRealizingSAGBI(
    G::Vector{QQMPolyRingElem},
    R::QQMPolyRing;
    method::Symbol = :hilbert_series,
    printWeights = false,
    returnOne = false,
)
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
                if (SagbiCriterion(G, R, -Int.(w); method = method))
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
