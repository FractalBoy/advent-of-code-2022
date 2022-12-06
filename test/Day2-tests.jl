@testset "Day 2" begin
    Day2 = include("../src/Day2.jl")
    testinput = """
    A Y
    B X
    C Z
    """
    @test Day2.solvepart1(testinput) === 15
    @test Day2.solvepart2(testinput) === 12
end
