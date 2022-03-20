class CheckFizzBuzz
  FIZZ_NUM = 3
  BUZZ_NUM = 5

  TEXT_MULTIPLE_3 = 'FIZZ'
  TEXT_MULTIPLE_5 = 'BUZZ'
  TEXT_MULTIPLE_3_AND_5 = 'FIZZBUZZ'

  def initialize(min, max)
    @max = max
    @min = min
  end

  def call_check_fizz_buzz
    @min.upto(@max) do |number|
      puts check_fizz_buzz(number)
    end
  end

# @param number
# @return Fizz Buzz FizzBuzzのいずれかの文字列
# FizzBuzzのチェクメソッドです
  def check_fizz_buzz(number)
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
end

CheckFizzBuzz.new(1,20).call_check_fizz_buzz