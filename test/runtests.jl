using Test

@testset "Day 1" begin
    Day1 = include("../src/Day1.jl")
    @test Day1.solvepart1("") === nothing
    @test Day1.solvepart2("") === nothing
end
