#!/usr/bin/env ruby

x = 0
while  x < 20
  x += 1
  case 
  when x % 3 == 0 && x % 5 == 0
    puts "FizzBuzz"
  when x % 3 == 0
    puts "Fizz"
  when x % 5 == 0
    puts "Buzz"
  else
    puts x
  end
end

