module Day10

mutable struct CPU
    cycle::Int64
    x::Int64
    signalstrength::Int64
    crt::String
    sprite::Int64

    function CPU()
        new(0, 1, 0, "", 0xE0_0000_0000)
    end
end

function drawpixel!(cpu::CPU)
    pixelmask = 0x80_0000_0000 >> ((cpu.cycle - 1) % 40)
    pixelon = (cpu.sprite & pixelmask) == pixelmask

    if pixelon
        cpu.crt *= "#"
    else
        cpu.crt *= "."
    end

    if cpu.cycle % 40 == 0
        cpu.crt *= "\n"
    end
end

function updatesignalstrength!(cpu::CPU)
    if cpu.cycle == 20 || (cpu.cycle - 20) % 40 == 0
        cpu.signalstrength += cpu.cycle * cpu.x
    end
end

function doinstructionpart1!(cpu::CPU, instruction::String, value::String="")
    cpu.cycle += 1
    updatesignalstrength!(cpu)

    if instruction == "addx"
        cpu.cycle += 1
        updatesignalstrength!(cpu)
        cpu.x += parse(Int64, value)
    end
end

function doinstructionpart2!(cpu::CPU, instruction::String, value::String="")
    if instruction == "noop"
        cpu.cycle += 1
        drawpixel!(cpu)
    elseif instruction == "addx"
        # begin instruction
        cpu.cycle += 1
        # draw first pixel
        drawpixel!(cpu)

        cpu.cycle += 1
        # draw second pixel
        drawpixel!(cpu)
        # finish instruction
        cpu.x += parse(Int64, value)
        # update sprite position
        cpu.sprite = 0xE0_0000_0000 >> (cpu.x - 1)
    end
end

function updatesignal!(cpu::CPU)
    if cpu.cycle == 20 || (cpu.cycle - 20) % 40 == 0
        cpu.signalstrength += cpu.cycle * cpu.x
    end
end

function solvepart1(input::String)
    cpu = CPU()
    lines = filter(!isempty, split(input, '\n'))

    for line in lines
        pieces = map(s -> String(s), split(line, ' '))

        if length(pieces) == 1
            doinstructionpart1!(cpu, pieces[1])
        elseif length(pieces) == 2
            doinstructionpart1!(cpu, pieces[1], pieces[2])
        end
    end

    return cpu.signalstrength
end


function solvepart2(input::String)
    cpu = CPU()
    lines = filter(!isempty, split(input, '\n'))

    for line in lines
        pieces = map(s -> String(s), split(line, ' '))

        if length(pieces) == 1
            doinstructionpart2!(cpu, pieces[1])
        elseif length(pieces) == 2
            doinstructionpart2!(cpu, pieces[1], pieces[2])
        end
    end

    return cpu.crt
end

end
