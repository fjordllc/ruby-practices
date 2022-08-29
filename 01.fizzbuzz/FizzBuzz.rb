#!/usr/bin/env ruby
Fizz = 3
Buzz = 5
numbers = (1..20)
numbers.each do |number|
  case 
  when number%Fizz == 0 && number%Buzz == 0
    puts "FizzBuzz"
  when number%Fizz == 0
    puts "Fizz"
  when number%Buzz == 0
    puts "Buzz" 
  else
  puts number
  end
end
