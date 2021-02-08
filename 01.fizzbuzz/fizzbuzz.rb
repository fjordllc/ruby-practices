number = 0
while number < 100
  number = number.next
  fizz = number % 3
  buzz = number % 5
  if fizz == 0 && buzz == 0
    puts "FizzBuzz"
  elsif buzz == 0
    puts "Buzz"
  elsif fizz == 0
    puts "Fizz"
  else
    puts number
  end
end
