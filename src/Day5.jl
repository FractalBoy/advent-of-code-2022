module Day5

struct Instruction
    quantity::Int64
    origin::Int64
    destination::Int64
end

function parsecrates(input::String)
    matrix = []
    lines = split(input, "\n")
    consumed = 0

    regex = r"(^(?:\[[A-Z]\]| {3})| (?:\[[A-Z]\]| {3}))"

    for line in lines
        consumed += 1

        matches = eachmatch(regex, line)

        if isempty(matches)
            break
        end

        crates = map(m -> replace(m.captures[1], r"[\[\]]" => "", r"\s+" => ""), matches)
        matrix = vcat(matrix, [crates])
    end

    width = maximum(map(length, matrix))
    height = length(matrix)

    for row in matrix
        append!(row, repeat([""], width - length(row)))
    end

    matrix = reverse(rotl90(reduce(hcat, matrix)), dims=1)
    return map(c -> filter(!isempty, c), eachcol(matrix)), filter(!isempty, lines[height+2:end])
end

function parseinstruction(instruction)::Instruction
    m = match(r"move (\d+) from (\d+) to (\d+)", instruction)
    return Instruction(
        parse(Int64, m.captures[1]),
        parse(Int64, m.captures[2]),
        parse(Int64, m.captures[3]))
end

function doinstruction1(crates, instruction::Instruction)
    for _ in 1:instruction.quantity
        popped = popfirst!(crates[instruction.origin])
        pushfirst!(crates[instruction.destination], popped)
    end
end

function doinstruction2(crates, instruction::Instruction)
    removed = splice!(crates[instruction.origin], 1:instruction.quantity)
    prepend!(crates[instruction.destination], removed)
end

function solve(input, doinstruction)
    crates, instructions = parsecrates(input)
    instructions = map(parseinstruction, instructions)

    for instruction in instructions
        doinstruction(crates, instruction)
    end

    return join(map(first, crates), "")
end


function solvepart1(input::String)
    return solve(input, doinstruction1)
end

function solvepart2(input::String)
    return solve(input, doinstruction2)
end

end
