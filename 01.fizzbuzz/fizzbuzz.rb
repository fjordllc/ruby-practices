#!/usr/bin/env ruby
# frozen_string_literal: true

def fizzbuzz
  (1..20).each do |x|
    if (x % 15).zero?
      puts 'FizzBuzz'
    elsif (x % 3).zero?
      puts 'Fizz'
    elsif (x % 5).zero?
      puts 'Buzz'
    else
      puts x
    end
  end
end

fizzbuzz
