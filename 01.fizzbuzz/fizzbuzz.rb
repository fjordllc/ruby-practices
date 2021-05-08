# frozen_string_literal: true

def fizzbuzz(num)
  1.upto(num) do |i|
    if (i % 3).zero? && (i % 5).zero?
      puts 'FizzBuzz'
    elsif (i % 3).zero?
      puts 'Fizz'
    elsif (i % 5).zero?
      puts 'Buzz'
    else
      puts i
    end
  end
end

fizzbuzz 20
