numbers = 1..20
numbers.each do |number|
  if number % 15 == 0
    p "FizzBuzz"
  elsif number % 3 == 0
    p "Fizz"
  elsif number % 5 == 0
    p "Buzz"
  else
    p number
  end
end