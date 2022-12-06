module Day4

function stringtorange(range)
    b, e = split(range, "-")
    return parse(Int64, b):parse(Int64, e)
end

function parseinput(input::String)
    lines = split(input, "\n")
    lines = filter(l -> l != "", lines)
    lines = map(l -> split(l, ","), lines)
    return map(((e1, e2),) -> (stringtorange(e1), stringtorange(e2)), lines)
end

function solve(operation::Function, input::String)
    elfpairs = parseinput(input)
    count = 0
    for (elf1, elf2) in elfpairs
        if operation(elf1, elf2)
            count += 1
        end
    end

    return count
end

function solvepart1(input::String)
    solve((e1, e2) -> e1 ⊆ e2 || e2 ⊆ e1, input)
end

function solvepart2(input::String)
    solve(!isdisjoint, input)
end

end
