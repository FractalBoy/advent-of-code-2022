module Day9

@enum Direction up down left right

struct Motion
    direction::Direction
    count::Int64
end

stringtodirection = Dict("U" => up, "D" => down, "L" => left, "R" => right)

function parseinput(input::String)::Vector{Motion}
    return map(a -> Motion(stringtodirection[a[1]], parse(Int64, a[2])), map(l -> split(l, ' '), filter(!isempty, split(input, '\n'))))
end

function move(headcoord::Tuple{Int64,Int64}, direction::Direction)::Tuple{Int64,Int64}
    movex, movey = 0, 0

    if direction === up
        movey = 1
    elseif direction === down
        movey = -1
    elseif direction === left
        movex = -1
    else
        movex = 1
    end

    return (headcoord[1] + movex, headcoord[2] + movey)
end

function adjust(newheadcoord::Tuple{Int64,Int64}, tailcoord::Tuple{Int64,Int64})::Tuple{Int64,Int64}
    distancex = newheadcoord[1] - tailcoord[1]
    distancey = newheadcoord[2] - tailcoord[2]

    if abs(distancex) <= 1 && abs(distancey) <= 1
        return tailcoord
    end

    movex = sign(distancex)
    movey = sign(distancey)

    return (tailcoord[1] + movex, tailcoord[2] + movey)
end

function solve(input::String, knots::Int64)
    steps = parseinput(input)

    knots = repeat([(0, 0)], knots + 1)

    visited = []

    push!(visited, knots[end])

    for step in steps
        for _ = 1:step.count
            knots[1] = move(knots[1], step.direction)

            for knot in eachindex(@view knots[1:end-1])
                knots[knot+1] = adjust(knots[knot], knots[knot+1])
            end

            push!(visited, knots[end])
        end
    end

    return length(unique(visited))
end

function solvepart1(input::String)
    return solve(input, 1)
end

function solvepart2(input::String)
    return solve(input, 9)
end

end
