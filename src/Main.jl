include("AOC.jl")

day = ARGS[1]
mod = include("Day$day.jl")

solveday(day, mod)
