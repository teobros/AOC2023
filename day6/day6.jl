lines = readlines("input.txt")

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
