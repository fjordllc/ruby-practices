#! /usr/bin/env ruby

require 'debug'

(1..50).each do |num|
  if (num % 15).zero?
    puts('FizzBuzz')
  elsif (num % 5).zero?
    puts('Buzz')
  elsif (num % 3).zero?
    puts('Fizz')
  end
end
