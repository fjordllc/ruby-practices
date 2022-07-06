#!/usr/bin/env ruby

num = 1

while num < 21
  if num % 15 == 0 then
    puts "FizzBuzz"
  elsif num % 3 == 0 then
    puts "Fizz"
  elsif num % 5 == 0 then
    puts "Buzz"
  else
    puts num
  end
  num += 1
end
