def fizzbuzz(num)
  case
  when num % 15 == 0
    "FizzBuzz"
  when num % 5 == 0
    "Buzz"
  when num % 3 == 0
    "Fizz"
  else
    num
  end
end

(1..20).each { |num| puts fizzbuzz(num) }