# @type [Integer]
max_number = 20

# @type [Integer] number
(1..max_number).each do |number|

  # @param [Integer] number
  def fizzBuzz(number)
    if number % 3 == 0 && number % 5 == 0
      puts "FizzBuzz"
    elsif number % 3 == 0
      puts "Fizz"
    elsif number % 5 == 0
      puts "Buzz"
    else
      puts number
    end
  end
  puts fizzBuzz(number)
end
