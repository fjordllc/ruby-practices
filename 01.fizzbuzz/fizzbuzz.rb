#!/usr/bin/env ruby

=begin
作成日:2023/4/21
作成者:h-osawa(GitHub:ha-osawa)
=end

number = 1
NUM_FIZZ = 3
NUM_BUZZ = 5

20.times do 
  if number % NUM_FIZZ == 0 && number % NUM_BUZZ == 0
    puts "FizzBuzz"
  elsif number % NUM_FIZZ == 0
    puts "Fizz"
  elsif number % NUM_BUZZ == 0
    puts "Buzz"
  else
    puts number
  end
  number += 1
end
