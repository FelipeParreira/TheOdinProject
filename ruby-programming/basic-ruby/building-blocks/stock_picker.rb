def stock_picker(arr)

	
	global_profit = []
	global_pairs = []
	orig_arr = arr


	orig_arr.each_index do |i|

		if i < orig_arr.length - 1

		  arr = orig_arr[(i + 1)...(orig_arr.length)]
		  local_profit = []
		  local_pairs = []

		  arr.each_index do |j|
		  	if arr[j] - orig_arr[i] > 0
		  		local_profit.push(arr[j] - orig_arr[i]);
		  		local_pairs.push([i, j + i + 1])
		  	end
		  end

		  	if local_profit.length == 0
		  		local_profit.push(0)
		  	end

			maxi = local_profit.max
			pair_maxi = local_pairs[local_profit.index(maxi)]

	   		global_profit.push(maxi)
			global_pairs.push(pair_maxi)

		end
	end

	maxim = global_profit.max
	pair_maxim = global_pairs[global_profit.index(maxim)]

	puts pair_maxim
	return	pair_maxim

end

stock_picker([17,3,6,9,15,8,6,1,10])
# outputs: 
# [1,4]  # for a profit of $15 - $3 == $12