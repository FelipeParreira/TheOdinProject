def substrings(str, dict)
	
	str = str.downcase.split(/\W/).select{ |item| item != "" }
	my_hash = {}


	str.each_entry do |el|
		dict.each_entry do |word|
			if el.include? word
				if !(my_hash.key?(word))
					my_hash[word] = 0
				end
				my_hash[word] += 1
			end
		end
	end

	puts my_hash
	return my_hash

end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("below", dictionary)
# outputs: { "below" => 1, "low" => 1 }
substrings("Howdy partner, sit down! How's it going?", dictionary)
# outputs: { "down" => 1, "how" => 2, "howdy" => 1,"go" => 1, "going" => 1, "it" => 2, "i" => 3, "own" => 1,"part" => 1,"partner" => 1,"sit" => 1 }