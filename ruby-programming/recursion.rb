def factorial(n)
  return 1 if n == 0
  return n * factorial(n - 1)
end

puts factorial(5)
puts factorial(3)

def pal(word)
  return true if word.length <= 1
  if word[0] == word[-1]
    word.slice!(0)
    word.slice!(-1)
    pal(word)
  else
    return false
  end
end

puts pal('anilina')
puts pal('racecar')
puts pal('asdfg')

def printSong(n)
  if n == 0
    puts "no more bottles of beer on the wall"
  else
    puts "#{n} bottles of beer on the wall"
    printSong(n - 1)
  end
end

printSong(5)

def fib(n)
  return n if n <= 1
  return fib(n - 1) + fib(n - 2)
end

puts fib(5)
puts fib(6)

def flatten(arr, orig_arr = arr, n = 0, len = arr.length)
  if n < len
    if arr[0].kind_of?(Array)
      a = arr.shift
      orig_arr = flatten(a, orig_arr)
    else
      a = arr.shift
      orig_arr.push(a)
    end
    flatten(arr, orig_arr, n + 1, len)
  else
    return orig_arr
  end
end

p flatten([1, 2, 3, 4])
p flatten([[1, 2], [3, 4], [5, 6]])
p flatten([[1, [8, 9]], [3, 4]])
p flatten([[1, [8, 9]], [3, 4], [5], 1, 2, [7, 6]])
p [[1, [8, 9]], [3, 4], [5], 1, 2, [7, 6]].flatten

$roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
}

def int2Roman(num, result='', n=0)
  if num != 0
    alg = num % 10
    num = num/10
      if alg <= 3 || n == 3
        result = $roman_mapping[1 * 10**n] * alg + result
      elsif alg == 4
        result = $roman_mapping[4 * 10**n] + result
      elsif alg < 9
        result = $roman_mapping[5 * 10**n] +  $roman_mapping[1 * 10**n] * (alg - 5) + result
      else
        result = $roman_mapping[9 * 10**n] + result
      end
    int2Roman(num, result, n + 1)
  else
    return result
  end
end

puts int2Roman(2018)
puts int2Roman(1000)
puts int2Roman(928)
puts int2Roman(767)
puts int2Roman(4999)

$roman_mapping_2 = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}

def roman2Int(num, result=0)
  return result if num.empty?
  a = $roman_mapping_2.keys.include?(num[0..1]) ? num[0..1] : num[0]
  roman2Int(num.sub(a, ''), result + $roman_mapping_2[a])
end

puts roman2Int('MMXVIII')
