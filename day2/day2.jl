lines = readlines("input_test.txt")

function preprocess(line)
    # ignore before :
    extractions = line[findfirst(isequal(':'),line)+2:end] 
    # split at ;
    extractions=split(extractions, ";")
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