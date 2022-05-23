# frozen_string_literal: true

def fizzbuzz(number1 = 3, number2 = 5, max_count = 20)
  1.upto(max_count) do |i|
    common_multiple = number1 * number2
    if (i % common_multiple).zero?
      puts 'FizzBuzz'
    elsif (i % number1).zero?
      puts 'Fizz'
    elsif (i % number2).zero?
      puts 'Buzz'
    else
      puts i
    end
  end
end

fizzbuzz
