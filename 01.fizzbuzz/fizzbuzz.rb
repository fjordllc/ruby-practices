# frozen_string_literal: true

def print_results
  (1..20).each do |i|
    if (i % 3).zero? && (i % 5).zero?
      p 'FizzBuzz'
    elsif (i % 3).zero?
      p 'Fizz'
    elsif (i % 5).zero?
      p 'Buzz'
    else
      p i
    end
  end
end

print_results
