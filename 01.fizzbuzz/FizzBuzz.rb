#!/usr/bin/env ruby
x = 1
20.times {
  case 
  when x % 15.0 == 0
    puts "FizzBuzz"
    x += 1
  when x % 3.0 == 0
    puts "Fizz"
    x += 1
  when x % 5.0 == 0
    puts "Buzz"
    x += 1
  else
    puts x
    x += 1
  end
}

