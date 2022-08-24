#!/usr/bin/env ruby
fizz = 3
buzz = 5
numbers = (1..20)
numbers.each do |number|
  case 
  when number%fizz == 0 && number%buzz == 0
    puts "FizzBuzz"
  when number%fizz == 0
    puts "Fizz"
  when number%buzz == 0
    puts "Buzz" 
  else
  puts number
  end
end
