@testset "Day 4" begin
    Day4 = include("../src/Day4.jl")
    testinput = """
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    """
    @test Day4.solvepart1(testinput) === 2
    @test Day4.solvepart2(testinput) === 4
end
