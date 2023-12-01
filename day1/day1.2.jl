lines = readlines("input.txt")

function preprocess(line_in)

	line_pp = replace(line_in, "one"=> "o1e")
	line_pp = replace(line_pp, "two"=>"t2o")
	line_pp = replace(line_pp, "three"=>"t3e")
	line_pp = replace(line_pp, "four"=>"f4r")
	line_pp = replace(line_pp, "five"=>"f5e")
	line_pp = replace(line_pp, "six"=>"s6x")
	line_pp = replace(line_pp, "seven"=>"s7n")
	line_pp = replace(line_pp, "eight"=>"e8t")
	line_pp = replace(line_pp, "nine"=>"n9e")
		
	return line_pp
end

function line_to_num(line)
	ascii = [Int(c) for c in line]
	num = deleteat!(ascii, ascii .> 57) .- 48
	num = num[1]*10 + num[end]
	return num
end

parsed_lines = map(preprocess, lines)
sum_nums = sum(map(line_to_num,parsed_lines))
print(sum_nums)
