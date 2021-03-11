# 約数(素因数)の中に3や5があるかどうか調べて判断する方法
require 'prime'
num_array = [*1..20]

num_array.each do |n|
  prime = []
  result = ''

  if n == 1
    result << n.to_s
    puts result
    next
  end

  Prime.prime_division(n).each do |prime_array|
    prime << prime_array.first
  end

  result << 'Fizz' if prime.include?(3)

  result << 'Buzz' if prime.include?(5)

  result << n.to_s if (prime.include?(3) || prime.include?(5)) == false

  puts result
end
