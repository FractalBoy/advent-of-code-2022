module Day11

struct Monkey
    number::Int64
    items::Vector{Int64}
    operation::Function
    test::Function
    truemonkey::Int64
    falsemonkey::Int64
end

DEBUG = false

function debugprint(input)
    if DEBUG
        print(input)
    end
end

function debugprintln(input)
    if DEBUG
        println(input)
    end
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

    stroper = m[3] == "+" ? "increases by" : "is multiplied by"

    if operand == "old"
        operation = old -> begin
            ret = operator(old, old)
            debugprintln("    Worry level $stroper itself to $ret.")
            return ret
        end
    else
        operand = parse(Int64, operand)
        operation = old -> begin
            ret = operator(old, operand)
            debugprintln("    Worry level $stroper $operand to $ret.")
            return ret
        end
    end

    test = new -> begin
        ret = new % divisibleby == 0
        debugprint("    Current worry level is")
        if !ret
            debugprint(" not")
        end

        debugprintln(" divisible by $divisibleby.")
        return ret
    end

    return Monkey(monkeynumber, items, operation, test, truemonkey, falsemonkey)
end

function doround!(monkeys::Vector{Monkey}, inspections::Dict{Int64,Int64})
    for monkey in monkeys
        debugprintln("Monkey $(monkey.number):")
        while !isempty(monkey.items)
            item = popfirst!(monkey.items)
            debugprintln("  Monkey inspects an item with a worry level of $item.")

            if monkey.number ∉ keys(inspections)
                inspections[monkey.number] = 0
            end

            inspections[monkey.number] += 1

            worrylevel = monkey.operation(item)
            debugprint("    Monkey gets bored with item. Worry level is divided by 3 to ")
            worrylevel ÷= 3
            debugprintln("$worrylevel.")

            if monkey.test(worrylevel)
                target = monkeys[monkey.truemonkey+1]
            else
                target = monkeys[monkey.falsemonkey+1]
            end

            debugprintln("    Item with worry level $worrylevel is thrown to monkey $(target.number).")
            push!(target.items, worrylevel)
        end
    end
end

function solvepart1(input::String)
    monkeys = map(m -> parsemonkey(m), filter(!isempty, split(input, "\n\n")))
    inspections = Dict{Int64,Int64}()

    for _ = 1:20
        doround!(monkeys, inspections)
    end

    return reduce(*, sort(collect(values(inspections)), rev=true)[1:2])
end

function solvepart2(input::String)
end

end
