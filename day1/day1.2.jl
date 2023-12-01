f = open("input.txt")
lines = readlines(f)

sum_nums = 0
for line in lines 
	line_pp = replace(line, "one"=> "o1e")
	line_pp = replace(line_pp, "two"=>"t2o")
	line_pp = replace(line_pp, "three"=>"t3e")
	line_pp = replace(line_pp, "four"=>"f4r")
	line_pp = replace(line_pp, "five"=>"f5e")
	line_pp = replace(line_pp, "six"=>"s6x")
	line_pp = replace(line_pp, "seven"=>"s7n")
	line_pp = replace(line_pp, "eight"=>"e8t")
	line_pp = replace(line_pp, "nine"=>"n9e")
	ascii = [Int(c) for c in line_pp]
	nums = deleteat!(ascii, ascii .> 57) .- 48
	global sum_nums += nums[1]*10 + nums[end]
end

print(sum_nums)
