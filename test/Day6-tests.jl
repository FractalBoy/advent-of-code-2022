@testset "Day 6" begin
    Day6 = include("../src/Day6.jl")
    testinput = """
    """
    @test Day6.solvepart1(testinput) === 7
    @test Day6.solvepart2(testinput) === nothing
end
