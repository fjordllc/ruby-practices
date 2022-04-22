#!/usr/bin/env ruby
# frozen_string_literal: true

class FizzBuzz
  def show
    (1..20).each do |number|
      if (number % 15).zero?
        puts 'FizzBuzz'
      elsif (number % 3).zero?
        puts 'Fizz'
      elsif (number % 5).zero?
        puts 'Buzz'
      else
        puts number
      end
    end
  end
end

fizz_buzz = FizzBuzz.new
fizz_buzz.show
