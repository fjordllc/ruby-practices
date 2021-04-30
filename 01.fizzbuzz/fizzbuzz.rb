#!/usr/bin/env ruby

(1..20).each do |number|
  if number % 15 == 0
    puts "FizzBuzz"
  elsif number % 3 == 0
    puts "Fizz"
  elsif number % 5 == 0
    puts "Buzz"
  else
    puts number
  end
end

puts "別の解答"
(1..20).each do |number|
  case 0
  when number % 15
    puts "FizzBuzz"
  when number % 3
    puts "Fizz"
  when number % 5
    puts "Buzz"
  else
    puts number
  end
end

