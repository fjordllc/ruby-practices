module Fizzbuzz
  NUMBERS = (1..20).to_a
  def self.build
    text = []
    NUMBERS.each do |number, i|
      if number % 15 == 0
        text << "FizzBuzz"
      elsif number % 3 == 0
        text << "Fizz"
      elsif number % 5 == 0
        text <<  "Buzz"
      else
        text << number
      end
    end
    text
  end
end