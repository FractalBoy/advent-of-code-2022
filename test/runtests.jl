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

@testset "Day 3" begin
    Day3 = include("../src/Day3.jl")
    testinput = """
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """
    @test Day3.solvepart1(testinput) === 157
    @test Day3.solvepart2(testinput) === 70
end

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
