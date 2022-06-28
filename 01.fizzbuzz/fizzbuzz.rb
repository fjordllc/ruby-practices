#!/usr/bin/env ruby

def fizzbuss(num = 0)
  return num unless fizz?(num) || buzz?(num)

  result = ''
  result += 'Fizz' if fizz?(num)
  result += 'Buzz' if buzz?(num)
  result
end

def fizz?(num)
  num % 3 == 0
end

def buzz?(num)
  num % 5 == 0
end

(1..20).each do |x|
  puts fizzbuss(x)
end
