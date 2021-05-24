number = 1
while number <= 20 do
  if number % 3 == 0 && number % 5 != 0
    puts "Fizz"
  elsif number % 5 == 0 && number % 3 != 0
    puts "Buzz"
  elsif number % 3 == 0 && number % 5 == 0
    puts "FizzBuzz"
  else
    puts number
  end
  number += 1
end
