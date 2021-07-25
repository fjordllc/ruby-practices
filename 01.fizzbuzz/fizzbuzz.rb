#!/usr/bin/env ruby

1.upto(20) do |i|
  result = ""
  
  if i % 3 == 0
    result += "Fizz"
  end
  
  if i % 5 == 0
    result += "Buzz"
  end
  
  if result.empty?
    result = i
  end
  
  puts result
end