#!/usr/bin/env ruby
(1..20).each do |n|
  if n % 3 == 0 && n % 5 == 0
    puts "FizzBuzz"
  elsif n % 3 != 0
    puts "Buzz"
  elsif n % 5 != 0
    puts "Fizz"
  else
    puts n
  end
end
