#!/usr/bin/env ruby

100.times do |n|
  n += 1
  if n % 15 == 0
    puts "FizzBuzz"
  elsif n % 3 == 0 
    puts "Fizz"
  elsif n % 5 == 0 
    puts "Buzz"
  else 
    puts n
  end
end