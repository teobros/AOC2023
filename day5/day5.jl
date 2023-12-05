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

function expand_map(map_orig)
    source = reshape([],0,1)
    destination_temp = reshape([],0,1)
    for i in 1:size(map_orig,1)
        source = vcat(source,collect(range(map_orig[i,2]+1,map_orig[i,2]+map_orig[i,3]))) 
        # +1 because the index are based 0 in the question
        destination_temp = vcat(destination_temp,collect(range(map_orig[i,1]+1,map_orig[i,1]+map_orig[i,3])))
    end
    destination = collect(range(1,maximum(source)))
    destination[source] = destination_temp
    return destination
end

function location(seed,maps_sequence)
    destination = source2dest(seed,maps_sequence[1])
    for imap = 2:length(maps_sequence)
        destination = source2dest(destination,maps_sequence[imap])
    end
    return destination
end
function source2dest(source,map)
    if source > maximum(map)
        dest = source
    else
        dest = map[source]
    end
    return dest
end


seed_to_soil, nlines = get_map(lines)
mapping = expand_map(seed_to_soil)
soils = map(x->source2dest(x,mapping), seeds)
deleteat!(lines, 1:nlines+1)

soil_to_fertilizer, nlines = get_map(lines)
mapping = expand_map(soil_to_fertilizer)
fertilizers = map(x->source2dest(x,mapping), soils)
deleteat!(lines, 1:nlines+1)

fertilizer_to_water, nlines = get_map(lines)
mapping = expand_map(fertilizer_to_water)
waters = map(x->source2dest(x,mapping), fertilizers)
deleteat!(lines, 1:nlines+1)

water_to_light, nlines = get_map(lines)
mapping = expand_map(water_to_light)
lights = map(x->source2dest(x,mapping), waters)
deleteat!(lines, 1:nlines+1)

light_to_temperature, nlines = get_map(lines)
mapping = expand_map(light_to_temperature)
temperatures = map(x->source2dest(x,mapping), lights)
deleteat!(lines, 1:nlines+1)

temperature_to_humidity, nlines = get_map(lines)
mapping = expand_map(temperature_to_humidity)
humidities = map(x->source2dest(x,mapping), temperatures)
deleteat!(lines, 1:nlines+1)

humidity_to_location, nlines = get_map(lines)
mapping = expand_map(humidity_to_location)
locations = map(x->source2dest(x,mapping), humidities)

answer1 = minimum(locations)