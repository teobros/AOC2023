lines = readlines("input.txt")

f=line->[x for x in split(line)]
matches = map(f,lines)
hands = [match[1] for match in matches]
hands = ["66922"; "66JAA"; "66AA4"]
bets = [parse(Int,match[2]) for match in matches]
bets = 1:3

function hand2score(hand)
    # Convert the hand to a score. The score is assigned like this:
    # - The number before the decimal is increasing by one for each
    #   scoring (1: high card, 2: one pair, ... , 7: five of a kind)
    # - The number after the decimal is the value of the strongest 
    #   card (2: 0/13, 3: 1/13, ... K: 11/13, A: 12/13)
    faces = ['2','3','4','5','6','7','8','9','T','J','Q','K','A']
    
    # upperscore determination
    countfaces = face->count(==(face), hand)
    numhand = map(countfaces, faces)
    sort!(deleteat!(numhand, numhand.==0))
    if numhand == [1,1,1,1,1]
        upperscore = 0.
    elseif numhand == [1,1,1,2]
        upperscore = 1.
    elseif numhand == [1,2,2]
        upperscore = 2.
    elseif numhand == [1,1,3]
        upperscore = 3.
    elseif numhand == [2,3]
        upperscore = 4.
    elseif numhand == [1,4]
        upperscore = 5.
    elseif numhand == [5]
        upperscore = 6.
    end

    # lowerscore determination
    lowerscore = 0.0
    f= x->findall(x .== faces)
    valuecard = map(f, collect(hand))
    valuecard = reduce(vcat,valuecard) .- 1
    # count decimals in base 13
    lowerscore = sum(valuecard.*(13 .^ range(-1,-5, 5)))

    score = upperscore + lowerscore

    return score
end

scores = map(hand2score, hands)

answer1 = sum(sortperm(scores).*bets)