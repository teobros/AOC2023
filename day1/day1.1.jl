f = open("input.txt")
lines = readlines(f)
sum_nums = 0
for line in lines 
	ascii = [Int(c) for c in line]
	nums = deleteat!(ascii, ascii .> 57) .- 48
	global sum_nums += nums[1]*10 + nums[end]
end
print(sum_nums)
