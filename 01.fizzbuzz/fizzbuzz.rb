# frozen_string_literal: true

class FizzBuzz
  def print_results
    i = 1
    while i <= 20
      if (i % 3).zero? && (i % 5).zero?
        p 'FizzBuzz'
      elsif (i % 3).zero?
        p 'Fizz'
      elsif (i % 5).zero?
        p 'Buzz'
      else
        p i
      end
      i += 1
    end
  end
end

fizz_buzz = FizzBuzz.new
fizz_buzz.print_results
