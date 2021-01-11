# frozen_string_literal: true

(1..100).each do |x|
  if (x % 3).zero? && (x % 5).zero?
    puts 'FizzBuzz'
  elsif (x % 3).zero?
    puts 'Fizz'
  elsif (x % 5).zero?
    puts 'Buzz'
  else
    puts x
  end
end
