lines = readlines("input_test.txt")

function line2vec(line)
    line = line[findfirst(isequal(':'),line)+2:end]
    vec = [parse(Int,num) for num in split(line)]
end

time = line2vec(lines[1])
distance = line2vec(lines[2])

function race2distance(time)
    chargetime = 0:time
    racetime = time .- chargetime
    race_distance = chargetime.*racetime
    return race_distance
end

racewins = (x,y)->sum(race2distance(x).>y)
wins = map(racewins, time, distance)

answer1 = prod(wins)

## part 2

function vec2total(vec)
    total=vec[end]

    oom = x-> floor(Int, log10(x))

    for i in length(vec)-1:-1:1
        total += vec[i]*10^(oom(total)+1)
    end
    return total
end

time2 = vec2total(time)
distance2 = vec2total(distance)