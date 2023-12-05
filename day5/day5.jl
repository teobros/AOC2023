using Distributed

lines = readlines("input_test.txt")

# get seeds
seeds = lines[1][findfirst(isequal(':'),lines[1])+2:end]
seeds = [parse(Int,num) for num in split(seeds)] 
# drop the lines of the seeds
deleteat!(lines, 1:2)

# get maps
function get_map(lines)
    idx_line = 2
    parsed_map = [parse(Int,num) for num in split(lines[idx_line])]
    # convert map vector to matrix
    parsed_map = reshape(parsed_map,(1,size(parsed_map,1)))
    try 
        while ~isempty(lines[idx_line+1])
            idx_line += 1
            next_line = [parse(Int,num) for num in split(lines[idx_line])]
            parsed_map = vcat(parsed_map, reshape(next_line,(1,size(next_line,1))))
        end
    catch
        # end of file, do nothing and avoid out of bound access to lines
    end
    return parsed_map, idx_line
end

function source2dest(source,map)
    dest=source
    for map_int in eachrow(map)
        if source in map_int[2]:map_int[2]+map_int[3]-1
            dest = map_int[1]+(source - map_int[2])
        end
    end
    return dest
end

# read all the maps
seed_to_soil, nlines = get_map(lines)
deleteat!(lines, 1:nlines+1)
soil_to_fertilizer, nlines = get_map(lines)
deleteat!(lines, 1:nlines+1)
fertilizer_to_water, nlines = get_map(lines)
deleteat!(lines, 1:nlines+1)
water_to_light, nlines = get_map(lines)
deleteat!(lines, 1:nlines+1)
light_to_temperature, nlines = get_map(lines)
deleteat!(lines, 1:nlines+1)
temperature_to_humidity, nlines = get_map(lines)
deleteat!(lines, 1:nlines+1)
humidity_to_location, nlines = get_map(lines)

function seed_to_location(seed)
    # do the mapping step by step
    temp = source2dest(seed,seed_to_soil)
    temp = source2dest(temp,soil_to_fertilizer)
    temp = source2dest(temp,fertilizer_to_water)
    temp = source2dest(temp,water_to_light)
    temp = source2dest(temp,light_to_temperature)
    temp = source2dest(temp,temperature_to_humidity)
    location = source2dest(temp,humidity_to_location)
    return location
end

locations = map(seed_to_location, seeds)

answer1 = minimum(locations)
println("answer 1: ", string(answer1))
## part 2
function seeds_range(seeds)
    seeds = seeds[1]:(seeds[1]+seeds[2]-1)
    return seeds
end

seeds = reshape(seeds,(2,Int(length(seeds)/2)))
seedranges = map(seeds_range, eachcol(seeds))

locations2 = zeros(Int,size(seedranges))
Threads.@threads for irange in 1:length(locations2)
    locations2[irange] = minimum(map(seed_to_location, seedranges[irange]))
end

answer2 = minimum(locations2)
println("answer 2: ", string(answer2))