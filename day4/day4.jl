# part 1
lines = readlines("input.txt")

function preprocess(line)
    # ignore before :
    extractions = line[findfirst(isequal(':'),line)+2:end] 
    # split at ;
    extractions=split(extractions, "|")
    winning = [parse(Int,num) for num in split(extractions[1])]   
    own_numbers = [parse(Int,num) for num in split(extractions[2])]
    return winning, own_numbers
end

numbers = map(preprocess, lines)

function card_score(numbers)
    is_winning = in.(numbers[1],[numbers[2]])
    return sum(is_winning)
end

scores = map(card_score,numbers)

answer1 = sum(2 .^ (scores[scores.>0].-1))