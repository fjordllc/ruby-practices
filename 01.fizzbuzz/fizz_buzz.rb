# @param number
# @return Fizz Buzz FizzBuzzのいずれかの文字列
# FizzBuzzのチェクメソッドです
#
def check_fizz_buzz(number)
  if number % 3 == 0 && number % 5 != 0
    puts "Fizz"
  elsif number % 3 != 0 && number % 5 == 0
    puts "Buzz"
  elsif number % 3 == 0 && number % 5 == 0
    puts "FizzBuzz"
  else
    puts number
  end
end
# RubyではForはほぼ使用されない。また、イテレータがインクリメントするような処理にはuptoメソッドの使用が推奨されている
1.upto(20){|n| puts check_fizz_buzz(n)}