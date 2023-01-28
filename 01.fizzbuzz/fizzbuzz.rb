def fizz_buzz(num)
  if num == 15
    "FizzBuzz"
  elsif num % 5 == 0
    "Buzz"
  elsif  num % 3 == 0
    "Fizz"
  else
    num
  end
end

(1..20).each { |num|
  puts fizz_buzz(num)
}
