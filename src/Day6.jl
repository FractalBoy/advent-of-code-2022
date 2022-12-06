module Day6

function solve(input::String, markerlength::Int64)
    window = ""

    for (i, char) in enumerate(input)
        window *= char

        if length(window) == markerlength
            if allunique(window)
                return i
            end

            window = window[2:end]
        end
    end
end

function solvepart1(input::String)
    return solve(input, 4)
end

function solvepart2(input::String)
    return solve(input, 14)
end

end
