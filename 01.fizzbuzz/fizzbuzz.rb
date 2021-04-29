#!/usr/bin/env ruby

numbers = [*1..20]

numbers.each do |number|
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
numbers = [*1..20]

numbers.each do |number|
  case
  when number % 15 == 0
    puts "FizzBuzz"
  when number % 3 == 0
    puts "Fizz"
  when number % 5 == 0
    puts "Buzz"
  else
    puts number
  end
end

