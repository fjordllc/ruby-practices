#!/usr/bin/env ruby

def fizz_buzz(numbers)
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
end

fizz_buzz(1..20)
