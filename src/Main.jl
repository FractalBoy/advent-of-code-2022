include("AOC.jl")

day = ARGS[1]
mod = include("Day$day.jl")

AOC.solveday(day, mod)
