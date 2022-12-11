@testset "Day 8" begin
    Day8 = include("../src/Day8.jl")
    testinput = """
    30373
    25512
    65332
    33549
    35390
    """
    @test Day8.solvepart1(testinput) === 21
    @test Day8.solvepart2(testinput) === 8
end
