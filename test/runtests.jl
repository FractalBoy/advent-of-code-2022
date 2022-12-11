using Test

tests = 1:9

if !isempty(ARGS)
    tests = ARGS
end

@testset "All tests" begin
    for t in tests
        include("Day$t-tests.jl")
    end
end
