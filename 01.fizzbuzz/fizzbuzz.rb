# frozen_string_literal: true

number = (1..20).to_a
number.each do |n|
  if (n % 3).zero? && (n % 5).zero?
    puts 'FizzBuzz'
  elsif (n % 3).zero?
    puts 'Fizz'
  elsif (n % 5).zero?
    puts 'Buzz'
  else
    puts n
  end
end
