module Enumerable
    def my_each
    	for i in 0...self.length
    		yield(self[i])
    	end
      self
    end

    def my_each_with_index
    	for i in 0...self.length
    		yield(self[i], i)
    	end
    	self
    end

    def my_select
    	newArr = []
    	for i in 0...self.length
    		if yield(self[i])
    			newArr.push(self[i])
    		end
    	end
    	newArr
    end

    def my_all?
    	for i in 0...self.length
    		if !yield(self[i])
    			return false
    		end
    	end
    	true 
    end

    def my_any?
    	for i in 0...self.length
    		if yield(self[i])
    			return true
    		end
    	end
    	false
    end

    def my_none?
    	for i in 0...self.length
    		if yield(self[i])
    			return false
    		end
    	end
    	true
    end

    def my_count(x=nil)
    	num = 0
    	if x.nil?
    		for i in 0...self.length
    			if yield(self[i])
    				num += 1
    			end
    		end
    	else
    		for i in 0...self.length
    			if self[i] == x
    				num += 1
    			end
    		end
    	end
    	return num
    end

    def my_map
    	myArr = []
    	for i in 0...self.length
    		myArr.push(yield(self[i]))
    	end
    	myArr
    end

    def my_inject(x=nil)
    	if x.nil?
    		x = self[0]
    		for i in 1...self.length
    			x = yield(x, self[i])
    		end
    	else
    		for i in 0...self.length
    			x = yield(x, self[i])
    		end
    	end
    	x
    end

     

    def my_map_mod1(proc)
    	myArr = []
    	for i in 0...self.length
    		myArr.push(proc.call(self[i]))
    	end
    	myArr
    end

    def my_map_mod2(proc=nil)
    	myArr = []
    	unless proc.nil?
    		for i in 0...self.length
    			myArr.push(proc.call(self[i]))
	    	end
    	else
    		for i in 0...self.length
    			myArr.push(yield(self[i]))
    		end
    	end
    	myArr
    end

    

end

def multiply_els(arr)
	arr.my_inject(1) {|running_total, item| running_total * item }
end

a = ["Bob", "Billy", "Joe"].my_each do |current_name| 
   		puts "#{current_name}! "
 	end

p a

a = ["Bob", "Billy", "Joe"].my_each_with_index do |current_name, i| 
   		puts "#{i}. #{current_name}"
 	end

p a

a = [1,2,3,4,5,6,7,8,100].my_select{|item| item%2==0 }

p a

a = [1,2,3,4,5,6,7,8,100].my_all?{|item| item%2==0 }

p a

a = [2,4,6,8,100].my_all?{|item| item%2==0 }

p a

a = [1,3,5,100].my_any?{|item| item%2==0 }

p a

a = [1,3,5].my_any?{|item| item%2==0 }

p a

a = [1,3,5].my_none?{|item| item%2==0 }

p a

a = [1,3,5,2].my_none?{|item| item%2==0 }

p a

a = [1,2,3,4,5,6,7,8,100].my_count{|item| item%2==0 }

p a

a = [1,3,5].my_count{|item| item%2==0 }

p a

a = [2,2,2].my_count(2)

p a

a = [1, 2, 3].my_map { |n| n * n }

p a

a = [2,4,6,8,100].my_inject(0){|running_total, item| running_total + item }

p a

a = [2,4,6,8,100].my_inject {|running_total, item| running_total + item }

p a

a = [2,8,100].my_inject(1) {|running_total, item| running_total * item }

p a

p multiply_els([2,4,5])

puts '=========' 

b = Proc.new { |n| return n * n }

a = [1, 2, 3].my_map_mod1(b) 

p a

a = [1, 2, 3].my_map(&b)

p a

a = [1, 2, 3].my_map_mod2(b) 

p a

puts '============'

a = [1, 2, 3].my_map_mod2(&b) 

p a

a = [1, 2, 3].my_map_mod2 { |n| n * n }

p a

a = [1, 2, 3].my_map_mod2(b) { |n| n * n }

p a
