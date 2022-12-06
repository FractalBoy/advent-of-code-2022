@testset "Day 6" begin
    Day6 = include("../src/Day6.jl")
    testinput = """
    mjqjpqmgbljsphdztnvjfqwrcgsmlb
    """
    @test Day6.solvepart1(testinput) === 7
    @test Day6.solvepart2(testinput) === 19
end
