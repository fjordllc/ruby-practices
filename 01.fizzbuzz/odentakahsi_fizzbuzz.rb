# frozen_string_literal: true

numbers = 1..20

numbers.each do |number|
  if (number % 3).zero? && (number % 5).zero?
    puts 'FizzBuzz'
  elsif (number % 5).zero?
    puts 'Buzz'
  elsif (number % 3).zero?
    puts 'Fizz'
  else
    puts number
  end
end
