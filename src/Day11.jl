module Day11

mutable struct Monkey
    number::Int64
    items::Vector{Int64}
    operation::Function
    div::Int64
    truemonkey::Int64
    falsemonkey::Int64
    inspections::Int64
end

function parsemonkey(input)::Monkey
    pattern = r"Monkey (\d+):\s+Starting items: ((?:\d+, )*\d+)\s+Operation: new = old ([\*\+]) (old|\d+)\s+Test: divisible by (\d+)\s+If true: throw to monkey (\d+)\s+If false: throw to monkey (\d+)"

    m = match(pattern, input)

    monkeynumber = parse(Int64, m[1])
    items = map(i -> parse(Int64, i), split(m[2], ", "))
    operator = m[3] == "+" ? (+) : (*)
    operand = m[4]
    divisibleby = parse(Int64, m[5])
    truemonkey = parse(Int64, m[6])
    falsemonkey = parse(Int64, m[7])

    if operand == "old"
        operation = old -> operator(old, old)
    else
        operand = parse(Int64, operand)
        operation = old -> operator(old, operand)
    end

    return Monkey(monkeynumber, items, operation, divisibleby, truemonkey, falsemonkey, 0)
end

function parsemonkeys(input)
    return map(m -> parsemonkey(m), filter(!isempty, split(input, "\n\n")))
end

function doround!(monkeys::Vector{Monkey}, reduceworrylevel::Function)
    for monkey in monkeys
        while !isempty(monkey.items)
            item = popfirst!(monkey.items)

            monkey.inspections += 1

            worrylevel = monkey.operation(item)
            worrylevel = reduceworrylevel(worrylevel)

            if worrylevel % monkey.div == 0
                target = monkey.truemonkey
            else
                target = monkey.falsemonkey
            end

            push!(filter(m -> m.number == target, monkeys)[1].items, worrylevel)
        end
    end
end

function solve(monkeys::Vector{Monkey}, iterations::Int64, reduceworrylevel::Function)
    for _ = 1:iterations
        doround!(monkeys, reduceworrylevel)
    end

    return reduce(*, sort(map(m -> m.inspections, monkeys), rev=true)[1:2])
end

function solvepart1(input::String)
    monkeys = parsemonkeys(input)
    return solve(monkeys, 20, worrylevel -> worrylevel ÷ 3)
end

function solvepart2(input::String)
    monkeys = parsemonkeys(input)
    mod = reduce(*, map(m -> m.div, monkeys))

    return solve(monkeys, 10000, worrylevel -> worrylevel % mod)
end

end
