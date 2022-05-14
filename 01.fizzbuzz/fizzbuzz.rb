numbers = [*1..20]
numbers.each do |num|
  if num % 15 == 0
    num = "FizzBuzz"
    puts num
  elsif num % 3 == 0
    num = "Fizz"
    puts num
  elsif num % 5 == 0
    num = "Buzz"
    puts num
  else
    puts num
  end
end
