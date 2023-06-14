#!/usr/bin/env ruby

(1..20).each do |num|
  if num % 15 == 0
    puts 'FizzBuzz'
  elsif num % 3 == 0
    puts 'Fizz'
  elsif num % 5 == 0
    puts 'Buzz'
  else
    print "\e[31m"
    puts num
    print "\e[0m"
  end
end