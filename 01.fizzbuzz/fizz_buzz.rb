class FizzBuzz
  FIZZ_NUM = 3
  BUZZ_NUM = 5

  TEXT_MULTIPLE_3 = 'Fizz'
  TEXT_MULTIPLE_5 = 'Buzz'
  TEXT_MULTIPLE_3_AND_5 = 'FizzBuzz'

  def initialize(min, max)
    @max = max
    @min = min
  end

  def call_convert_fizzbuzz
    @min.upto(@max) do |number|
      puts convert_fizzbuzz(number)
    end
  end

  def convert_fizzbuzz(number)
    if (number % FIZZ_NUM).zero? && number % BUZZ_NUM != 0
      puts TEXT_MULTIPLE_3
    elsif number % FIZZ_NUM != 0 && (number % BUZZ_NUM).zero?
      puts TEXT_MULTIPLE_5
    elsif (number % FIZZ_NUM).zero? && (number % BUZZ_NUM).zero?
      puts TEXT_MULTIPLE_3_AND_5
    else

      puts number
    end
  end

  FizzBuzz.new(1, 20).call_convert_fizzbuzz
end