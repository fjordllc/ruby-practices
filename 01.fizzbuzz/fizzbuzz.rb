#! /usr/bin/env ruby
# frozen_string_literal: true

(1..20).each do |num|
  if (num % 3).zero? && (num % 5).zero?
    puts 'FizzBuzz'
  elsif (num % 3).zero?
    puts 'Fizz'
  elsif (num % 5).zero?
    puts 'Buzz'
  else
    puts num
  end
end
