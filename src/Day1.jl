module Day1

function parseelves(input::String)
    return map(elf -> map(food -> parse(Int, strip(food)), filter(food -> food != "", split(elf, "\n"))), split(input, "\n\n"))
end

function solvepart1(input::String)
    elves = parseelves(input)
    return maximum(map(sum, elves))
end

function solvepart2(input::String)
    elves = parseelves(input)
    sums = map(sum, elves)
    topthree = sort(sums, rev=true)[1:3]
    return sum(topthree)
end

end
