using Test

@testset "Day 1" begin
    Day1 = include("../src/Day1.jl")
    testinput = """
          1000
          2000
          3000

          4000

          5000
          6000

          7000
          8000
          9000

          10000
      """
    @test Day1.solvepart1(testinput) === 24000
    @test Day1.solvepart2(testinput) === 45000
end

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
