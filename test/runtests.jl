using Oscar
using SagbiGbDetection
using Test

weight_tuples(weights) = Set([Tuple(Int.(w)) for w in weights])

@testset "SagbiGbDetection.jl" begin
    @testset "Groebner basis detection" begin
        R, (x, y, z) = polynomial_ring(QQ, ["x", "y", "z"])
        G = [x^5 + y^3 + z^2 - 1, x^2 + y^2 + z - 1, x^6 + y^5 + z^3 - 1]

        @test weight_tuples(weightVectorsRealizingGB(G, R)) == Set([(12, 15, 27)])
        @test BuchbergerCriterion(G, R, [12, 15, 27])

        S, (u, v) = polynomial_ring(QQ, ["u", "v"])
        H = [u^2 + v^2 - 1, 2*u*v - 1]

        @test isempty(weightVectorsRealizingGB(H, S))
    end

    @testset "SAGBI basis detection" begin
        R, (x, y, z) = polynomial_ring(QQ, ["x", "y", "z"])
        F = [x + y + z, x*y + x*z + y*z, x*y*z]

        expected_symmetric_weights = Set([
            (1, 2, 3),
            (1, 3, 2),
            (2, 1, 3),
            (2, 3, 1),
            (3, 1, 2),
            (3, 2, 1),
        ])

        @test weight_tuples(weightVectorsRealizingSAGBI(F, R)) == expected_symmetric_weights
        @test weight_tuples(weightVectorsRealizingSAGBI(F, R; method = :initial_ideal)) == expected_symmetric_weights
        @test SagbiCriterion(F, R, [3, 2, 1])
        @test SagbiCriterion(F, R, [3, 2, 1]; method = :hilbert)
        @test SagbiCriterion(F, R, [3, 2, 1]; method = :initial_ideal)
        @test_throws ArgumentError SagbiCriterion(F, R, [3, 2, 1]; method = :subduction)

        S, (u, v) = polynomial_ring(QQ, ["u", "v"])
        H = [u + v, u*v, u*v^2]

        @test isempty(weightVectorsRealizingSAGBI(H, S))
        @test isempty(weightVectorsRealizingSAGBI(H, S; method = :initial_ideal))
    end
end
