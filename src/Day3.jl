module Day3

function parseinput1(input::String)
    lines = filter(l -> l != "", split(input, "\n"))
    return map(l -> (l[1:end÷2], l[end÷2+1:end]), lines)
end

function parseinput2(input::String)
    lines = filter(l -> l != "", split(input, "\n"))
    return reshape(lines, (3, length(lines) ÷ 3))
end

function getshareditemtype(items1, items...)
    allitems = map(x -> split(x, ""), [items1, items...])
    return intersect(allitems...)[1][1]
end

function gettypepriority(char::Char)
    if 'a' <= char <= 'z'
        return codepoint(char) - codepoint('a') + 1
    elseif 'A' <= char <= 'Z'
        return codepoint(char) - codepoint('A') + 27
    end
end

function solvepart1(input::String)
    sum(map(gettypepriority ∘ (x -> getshareditemtype(x[1], x[2])), parseinput1(input)))
end

function solvepart2(input::String)
    mat = parseinput2(input)
    sum = 0
    for col in eachcol(mat)
        sum += gettypepriority(getshareditemtype(col...))
    end

    return sum
end

end
