using Downloads

function getinputforday(day)
    path = joinpath(Base.source_dir(), "..", ".sessionid")
    sessionid = open(path) do f
        String(readchomp(f))
    end

    output = IOBuffer()
    r = Downloads.request(
        "https://adventofcode.com/2022/day/$day/input",
        output=output,
        headers=Dict(
            "Cookie" => "session=$sessionid",
            "User-Agent" => "https://github.com/FractalBoy/advent-of-code-2022 by reisner.marc@gmail.com"
        )
    )

    String(take!(output))
end


function solveday(day)
    input = getinputforday(day)
    imp = include("Day$day.jl")

    data = ["", ""]
    times = [0.0, 0.0]

    if isdefined(imp, :solvepart1)
        (result, time) = @timed Base.invokelatest(imp.solvepart1, input)
        setindex!(data, string(result), 1)
        setindex!(times, time, 1)
    end

    if isdefined(imp, :solvepart2)
        (result, time) = @timed Base.invokelatest(imp.solvepart2, input)
        setindex!(data, string(result), 2)
        setindex!(times, time, 2)
    end

    maxlen = maximum(map(length, data))
    print("Part | Result")

    if maxlen < 7
        maxlen = 7
    end

    print(repeat(" ", maxlen - 7))
    println(" | Time")
    print("-----+--------")
    print(repeat("-", maxlen - 7))
    println("+-----------")

    for i in eachindex(data)
        if length(data[i]) == 0
            continue
        end

        print("$i    | " * data[i])
        print(repeat(" ", maxlen - length(data[i])))
        print("| ")
        println(times[i])
    end
end
