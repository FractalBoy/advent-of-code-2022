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

    for line in lines
        consumed += 1

        if startswith(line, " 1")
            break
        end

        crates = []
        crate = ""
        skip = 0

        for char in line
            if skip > 0
                skip -= 1
                continue
            end

            crate *= char

            if length(crate) == 3
                crate = replace(crate, r"[\[\]]" => "", r"\s+" => "")
                push!(crates, crate)
                crate = ""
                skip = 1
            end
        end

        matrix = vcat(matrix, [crates])
    end

    width = maximum(map(length, matrix))

    for row in matrix
        append!(row, repeat([""], width - length(row)))
    end

    matrix = reverse(rotl90(reduce(hcat, matrix)), dims=1)
    return map(c -> filter(!isempty, c), eachcol(matrix)), filter(!isempty, lines[consumed+1:end])
end

function parseinstruction(instruction)::Instruction
    m = match(r"move (\d+) from (\d+) to (\d+)", instruction)
    return Instruction(
        parse(Int64, m.captures[1]),
        parse(Int64, m.captures[2]),
        parse(Int64, m.captures[3]))
end

function doinstruction(crates, instruction::Instruction)
    for _ in 1:instruction.quantity
        popped = popfirst!(crates[instruction.origin])
        pushfirst!(crates[instruction.destination], popped)
    end
end

function solvepart1(input::String)
    crates, instructions = parsecrates(input)
    instructions = map(parseinstruction, instructions)

    for instruction in instructions
        doinstruction(crates, instruction)
    end

    return join(map(first, crates), "")
end

function solvepart2(input::String)
end

end
