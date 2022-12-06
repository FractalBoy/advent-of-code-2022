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
