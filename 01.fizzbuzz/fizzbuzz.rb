# frozen_string_literal: true

def fizzbuzz(max_number)
  1.upto(max_number) do |number|
    if (number % 15).zero?
      puts 'fizzbuzz'
    elsif (number % 5).zero?
      puts 'buzz'
    elsif (number % 3).zero?
      puts 'fizz'
    else
      puts number
    end
  end
end

max_number = 100
fizzbuzz(max_number)
