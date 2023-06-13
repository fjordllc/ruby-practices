#!/bin/env ruby
x = 1
while x <= 20
  case
  	when x % 3 == 0 && x % 5 != 0
  		puts "Fizz"
  	when x % 3 != 0 && x % 5 == 0
  		puts "Buzz"
  	when x % 3 ==0  && x % 5 == 0
 			puts "FizzBuzz"
 		else
 			puts x
	end
	x += 1
end

