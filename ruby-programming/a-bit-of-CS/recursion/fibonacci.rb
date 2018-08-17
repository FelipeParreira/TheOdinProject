# Fibonacci sequence: 0, 1, 1, 2, 3, 5, 8, 13...
# Fibonacci sequence here is considered to start at the zero-eth element (which is 0)

# fibo function returns the n-th element of the Fibonacci sequence
def fibo(n)
  a, b, c = 0, 0, 0
  for i in 1..n
    c, b = b, a
    a = i== 1 ? 1 : b + c
  end
  return a
end

puts fibo(0)
puts fibo(1)
puts fibo(2)
puts fibo(3)
puts fibo(4)
puts fibo(5)
puts fibo(6)

# fibo_rec does the same as the fibo function, but recursively
def fibo_rec(n)
  return n <= 1 ? n : fibo(n - 1) + fibo(n - 2)
end

puts fibo_rec(0)
puts fibo_rec(1)
puts fibo_rec(2)
puts fibo_rec(3)
puts fibo_rec(4)
puts fibo_rec(5)
puts fibo_rec(6)

# fibs returns n members of the fibonacci sequence
def fibs(n)
  a, b, c = 0, 0, 0
  arr = [a]
  for i in 1..(n - 1)
    c, b = b, a
    a = i == 1 ? 1 : b + c
    arr.push(a)
  end
  return arr
end

p fibs(6)

# fibs_rec does the same as fibs but recursively
def fibs_rec(n, arr = [])
  arr.unshift(n - 1 <= 1 ? n - 1 : fibo(n - 2) + fibo(n - 3))
  return n - 1 > 0 ? fibs_rec(n - 1, arr) : arr
end

p fibs_rec(6)
