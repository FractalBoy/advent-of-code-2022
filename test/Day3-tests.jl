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
