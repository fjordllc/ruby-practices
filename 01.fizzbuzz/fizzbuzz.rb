#!/usr/bin/env ruby

(1..20).each do |n|
  s = if (n % 15).zero?
    'FizzBuzz'
  elsif (n % 3).zero?
    'Fizz'
  elsif (n % 5).zero?
    'Buzz'
  else
    n
  end
  puts s
end

