module Day8

function parseinput(input::String)
    lines = filter(!isempty, split(input, '\n'))

    height = length(lines)
    width = length(lines[1])

    matrix = zeros(Int64, width, height)

    row = 1

    for line in lines
        trees = map(t -> parse(Int64, t), split(line, ""))
        matrix[row, :] = trees
        row += 1
    end

    return matrix
end

function istreevisible(matrix, row, column)
    tree = matrix[row, column]

    right = matrix[row, column+1:end]
    left = matrix[row, 1:column-1]
    up = matrix[1:row-1, column]
    down = matrix[row+1:end, column]

    for othertrees in [right, left, up, down]
        if isempty(othertrees)
            return true
        elseif all(t -> t < tree, othertrees)
            return true
        end
    end

    return false
end

function gettreescore(matrix, row, column)
    tree = matrix[row, column]

    right = matrix[row, column+1:end]
    left = reverse(matrix[row, 1:column-1])
    up = reverse(matrix[1:row-1, column])
    down = matrix[row+1:end, column]

    score = 1

    for othertrees in [right, left, up, down]
        found = false

        for (i, t) in enumerate(othertrees)
            if t >= tree
                score *= i
                found = true
                break
            end
        end

        if !found
            score *= length(othertrees)
        end
    end

    return score
end

function solvepart1(input::String)
    trees = parseinput(input)

    visible = 0

    for i in CartesianIndices(trees)
        if istreevisible(trees, i[1], i[2])
            visible += 1
        end
    end

    return visible
end

function solvepart2(input::String)
    trees = parseinput(input)

    maxscore = 0

    for i in CartesianIndices(trees)
        score = gettreescore(trees, i[1], i[2])

        if score > maxscore
            maxscore = score
        end
    end

    return maxscore
end

end
