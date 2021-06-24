#!/usr/bin/env ruby

x = 0
while x < 20
  x += 1
  if x % 15 == 0
    puts "FizzBuzz"
  elsif x % 3 == 0
    puts "Fizz"
  elsif x % 5 == 0
    puts "Buzz"
  else
    puts x
  end
end
