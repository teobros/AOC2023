lines = readlines("input.txt")

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

# do the mapping step by step
soils = map(x->source2dest(x,seed_to_soil),seeds)
fertilizers = map(x->source2dest(x,soil_to_fertilizer), soils)
waters = map(x->source2dest(x,fertilizer_to_water), fertilizers)
lights = map(x->source2dest(x,water_to_light), waters)
temperatures = map(x->source2dest(x,light_to_temperature), lights)
humidities = map(x->source2dest(x,temperature_to_humidity), temperatures)
locations = map(x->source2dest(x,humidity_to_location), humidities)

answer1 = minimum(locations)
## part 2
function seeds_range(seeds)
    seeds = seeds[1]:(seeds[1]+seeds[2]-1)
    return seeds
end

a = seeds_range(seeds[1:2])

function seedrange_to_location(seed_range)
    temp = map(x->source2dest(x,seed_to_soil),seed_range)
    temp = map(x->source2dest(x,soil_to_fertilizer), temp)
    temp = map(x->source2dest(x,fertilizer_to_water), temp)
    temp = map(x->source2dest(x,water_to_light), temp)
    temp = map(x->source2dest(x,light_to_temperature), temp)
    temp = map(x->source2dest(x,temperature_to_humidity), temp)
    locations = map(x->source2dest(x,humidity_to_location), temp)
    return minimum(locations)
end
seeds = reshape(seeds,(2,Int(length(seeds)/2)))
seedranges = map(seeds_range, eachcol(seeds))

locations = map(seedrange_to_location,seedranges)

