numbers = (1..20).to_a

numbers.each do |number|
  if number % 3 == 0 && number % 5 == 0
    puts "FizzBuz"
  elsif number % 3 == 0
    puts "Fizz"
  elsif number % 5 == 0
    puts "Buzz"
  else
    puts number
  end
end
