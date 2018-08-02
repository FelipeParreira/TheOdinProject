def caesar_cipher(str, factor)

	
	string_array = []

	str.each_byte do |c|

		c_orig = c

		if c <= 90 && c >= 65
			c += 32
		end

		if c <= 122 && c >= 97
			c += factor
			if c > 122
				c -= 26
			elsif c < 97
				c += 26
			end
			if c_orig <= 90
				c -= 32
			end	
		end 

		string_array.push(c.chr)
	end

	final_string = string_array.join('')
	puts final_string
	return final_string

end

caesar_cipher("What a string!", 5)
# outputs: "Bmfy f xywnsl!"