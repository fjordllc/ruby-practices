#!/usr/bin/env ruby

def fizzbuss(num = 0)
  return num unless fizz?(num) || buzz?(num)

  result = ''
  result += 'FIZZ' if fizz?(num)
  result += 'BUZZ' if buzz?(num)
  result
end

def fizz?(num)
  num % 3 == 0
end

def buzz?(num)
  num % 5 == 0
end

(1..20).to_a.each do |x|
  puts fizzbuss(x)
end
