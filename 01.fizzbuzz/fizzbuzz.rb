numbers = 0

20.times do
  numbers += 1
  if numbers % 3 == 0 && numbers % 5 == 0
    puts "FizzBuzz"
  elsif numbers % 3 == 0
    puts "Fizz"
  elsif numbers % 5 == 0
    puts "Buzz"
  else
    puts numbers
  end
end
