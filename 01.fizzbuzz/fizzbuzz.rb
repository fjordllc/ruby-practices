#!/usr/bin/env ruby

=begin
作成日:2023/4/21
作成者:h-osawa(GitHub:ha-osawa)
=end

number = 1
NumFizz = 3
NumBuzz = 5

20.times do 
  if number % NumFizz == 0 && number % NumBuzz == 0
    puts "FizzBuzz"
  elsif number % NumFizz == 0
    puts "Fizz"
  elsif number % NumBuzz == 0
    puts "Buzz"
  else
    puts number
  end
  number += 1
end
