#!/usr/bin/env ruby

(1..20).each do |num|
  if num.modulo(15).zero?
    puts 'FizzBuzz'
  elsif num.modulo(3).zero?
    puts 'Fizz'
  elsif num.modulo(5).zero?
    puts 'Buzz'
  else
    puts num
  end
end
