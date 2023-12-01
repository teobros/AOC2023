lines = readlines("input.txt")

function line_to_num(line)
	ascii = [Int(c) for c in line]
	num = deleteat!(ascii, ascii .> 57) .- 48
	num = num[1]*10 + num[end]
	return num
end

sum_nums = sum(map(line_to_num, lines))

print(sum_nums)
