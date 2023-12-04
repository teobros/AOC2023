# part 1
lines = readlines("input_test.txt")

function preprocess(line)
    # ignore before :
    extractions = line[findfirst(isequal(':'),line)+2:end] 
    # split at ;
    extractions=split(extractions, ";")
    # read the rgb values from each line
    rgb = zeros(Int,size(extractions,1),3)
    for i in range(1,size(extractions,1))
        entries = extractions[i]
        rgb_string = split(entries,",")
        for rgb_item in rgb_string
            if occursin("red",rgb_item)
                rgb[i,1] = parse(Int,filter(isdigit,rgb_item))
            elseif occursin("green",rgb_item)
                rgb[i,2] = parse(Int,filter(isdigit,rgb_item))
            elseif occursin("blue",rgb_item)
                rgb[i,3] = parse(Int,filter(isdigit,rgb_item))
            end
        end
    end
    return rgb
end

rgb = map(preprocess, lines)

function isvalid(entry)
    return all(entry[:,1].<=12) & all(entry[:,2].<=13) & all(entry[:,3].<=14)
end

id_correct = map(isvalid,rgb)
ids = range(1,size(id_correct,1))
answer1 = sum(ids[id_correct])
# part 2
function reqs_per_game(entry)
    reqs =  maximum(entry,dims=1)
    power = prod(reqs)
end

powers = map(reqs_per_game, rgb)
answer2 = sum(powers)