module Day7

abstract type FileSystemEntity end

struct Directory <: FileSystemEntity
    dirname::String
    parent::Union{Nothing,Directory}
    children::Vector{<:FileSystemEntity}
end

struct File <: FileSystemEntity
    filename::String
    size::Int64
    parent::Directory
end

function goup(dir::Directory)
    return dir.parent
end

function isdirlisting(listing::String)
    return startswith(listing, "dir")
end

function getdirlisting(listing::String)
    m = match(r"dir (.+)", listing)

    if isnothing(m)
        return nothing
    end

    return m.captures[1]
end

function getfilelisting(listing::String)
    m = match(r"(\d+)\s+(.+)", listing)

    if isnothing(m)
        return nothing
    end

    return m.captures[2], m.captures[1]
end

function getlistings!(commands::Vector{String})
    listings::Vector{String} = []

    while !isempty(commands)
        if startswith(commands[1], '$')
            break
        end

        push!(listings, popfirst!(commands))
    end

    return listings
end

function islscommand(command::String)
    return startswith(command, "\$ ls")
end

function getcdcommand(command::String)
    m = match(r"\$ cd (.+)", command)

    if isnothing(m)
        return nothing
    end

    return convert(String, m.captures[1])
end

function cd!(dir::Union{Nothing,Directory}, child::String)
    if isnothing(dir) && child == "/"
        return Directory("/", nothing, Vector{Union{File,Directory}}())
    end

    if child === ".."
        return goup(dir)
    end

    childdirs = filter(e -> isa(e, Directory), dir.children)
    return filter(e -> e.dirname === child, childdirs)[1]
end

function ls!(dir::Directory, listings::Vector{String})
    for listing in listings
        if isdirlisting(listing)
            childdirname = getdirlisting(listing)
            childdir = Directory(childdirname, dir, Vector{Union{File,Directory}}())
            push!(dir.children, childdir)
        else
            childfilename, childsize = getfilelisting(listing)
            childfile = File(childfilename, parse(Int64, childsize), dir)
            push!(dir.children, childfile)
        end
    end
end

function runcommands(commands::Vector{String})
    cwd = nothing

    while !isempty(commands)
        command = popfirst!(commands)

        if islscommand(command)
            listings = getlistings!(commands)
            ls!(cwd, listings)
        else
            dir = getcdcommand(command)
            cwd = cd!(cwd, dir)
        end
    end

    while !isnothing(cwd.parent)
        cwd = cwd.parent
    end

    return cwd
end

function du(dir::Directory, fullpath::String, dirsizes::Dict{String,Int64})
    total = 0

    for child in dir.children
        if isa(child, File)
            total += child.size
        else
            total += du(child, fullpath * "/" * child.dirname, dirsizes)
        end
    end

    dirsizes[fullpath] = total
    return total
end

function calculatedirsizes(input::String)
    commands = filter(!isempty, map(s -> convert(String, s), split(input, '\n')))
    root = runcommands(commands)
    dirsizes = Dict{String,Int64}()
    du(root, "/", dirsizes)

    return dirsizes
end

function solvepart1(input::String)
    dirsizes = calculatedirsizes(input)
    return sum(filter(s -> s <= 100000, (collect ∘ values)(dirsizes)))
end

function solvepart2(input::String)
    dirsizes = calculatedirsizes(input)
    freespace = 70000000 - dirsizes["/"]
    neededspace = 30000000 - freespace
    largeenough = filter(s -> s >= neededspace, (collect ∘ values)(dirsizes))
    return minimum(largeenough)
end

end
