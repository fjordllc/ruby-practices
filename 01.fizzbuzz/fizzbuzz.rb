#!/usr/bin/env ruby
# frozen_string_literal: true

def fizzbuzz
  (1..20).each do |n|
    if (n % 15).zero?
      puts 'FizzBuzz'
    elsif (n % 3).zero?
      puts 'Fizz'
    elsif (n % 5).zero?
      puts 'Buzz'
    else
      puts n
    end
  end
end

fizzbuzz
