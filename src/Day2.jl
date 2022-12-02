module Day2

@enum HandShape rock paper scissors
@enum Result win lose draw

stringtohandshape = Dict{String,HandShape}(
    "A" => rock,
    "B" => paper,
    "C" => scissors,
    "X" => rock,
    "Y" => paper,
    "Z" => scissors)

stringtoresult = Dict{String,Result}(
    "X" => lose,
    "Y" => draw,
    "Z" => win
)

mutable struct RoundA
    opponent::HandShape
    me::HandShape
end

struct RoundB
    opponent::HandShape
    result::Result
end

parsecommon = (x -> map(l -> split(l, " "), x)) ∘ (x -> filter(l -> l != "", x)) ∘ (x -> split(x, "\n"))
parseinput1 = (x -> map(round -> RoundA(stringtohandshape[round[1]], stringtohandshape[round[2]]), x)) ∘ parsecommon
parseinput2 = (x -> map(round -> RoundB(stringtohandshape[round[1]], stringtoresult[round[2]]), x)) ∘ parsecommon

function compare(handa::HandShape, handb::HandShape)
    if handa === handb
        return 0
    elseif handa === rock && handb === paper
        return -1
    elseif handa === rock && handb === scissors
        return 1
    elseif handa === paper && handb === rock
        return 1
    elseif handa === paper && handb === scissors
        return -1
    elseif handa === scissors && handb === rock
        return -1
    elseif handa === scissors && handb === paper
        return 1
    end
end

function score(round::RoundA)
    score = 0

    if round.me === rock
        score += 1
    elseif round.me === paper
        score += 2
    else
        score += 3
    end

    winner = compare(round.me, round.opponent)

    if winner === 0
        score += 3
    elseif winner === 1
        score += 6
    end

    return score
end

function choose(round::RoundB)
    chosen = RoundA(round.opponent, round.opponent)

    if round.result === win
        if round.opponent === rock
            chosen.me = paper
        elseif round.opponent === paper
            chosen.me = scissors
        elseif round.opponent === scissors
            chosen.me = rock
        end
    elseif round.result === lose
        if round.opponent === rock
            chosen.me = scissors
        elseif round.opponent === paper
            chosen.me = rock
        else
            chosen.me = paper
        end
    end

    return chosen
end

function solvepart1(input::String)
    rounds = parseinput1(input)
    return map(score, rounds) |> sum
end

function solvepart2(input::String)
    rounds = parseinput2(input)
    return map(score ∘ choose, rounds) |> sum
end

end
