@testset "Day 9" begin
    Day9 = include("../src/Day9.jl")
    testinput = """
    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2
    """
    @test Day9.solvepart1(testinput) === 13

    testinput = """
    R 5
    U 8
    L 8
    D 3
    R 17
    D 10
    L 25
    U 20
    """
    @test Day9.solvepart2(testinput) === 36
end
