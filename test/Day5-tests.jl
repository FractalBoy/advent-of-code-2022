@testset "Day 5" begin
    Day5 = include("../src/Day5.jl")
    testinput = """
        [D]
    [N] [C]
    [Z] [M] [P]
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """
    @test Day5.solvepart1(testinput) === "CMZ"
    @test Day5.solvepart2(testinput) === "MCD"
end
