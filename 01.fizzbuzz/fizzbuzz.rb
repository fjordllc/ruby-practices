# frozen_string_literal: true

(1..20).each do |i|
  if (i % 15).zero?
    puts 'FizzzBuzz'
  elsif (i % 3).zero?
    puts 'Fizz'
  elsif (i % 5).zero?
    puts 'Buzz'
  else
    puts i
  end
end
