def bubble_sort(arr)
	
		0.upto(arr.length - 2) do |i|
			(i + 1).upto(arr.length - 1) do |j|
				if arr[i] > arr[j]
					arr[i], arr[j] = arr[j], arr[i]
				end
			end
		end

	p arr
	return arr
end

bubble_sort([4,3,78,2,0,2])
# outputs: [0,2,2,3,4,78]

def bubble_sort_by(arr)
	0.upto(arr.length - 2) do |i|
			(i + 1).upto(arr.length - 1) do |j|
				if yield(arr[i], arr[j]) > 0
					arr[i], arr[j] = arr[j], arr[i]
				end
			end
		end

	p arr
	return arr 
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
 	left.length - right.length
  end
 # outputs: ["hi", "hey", "hello"]
