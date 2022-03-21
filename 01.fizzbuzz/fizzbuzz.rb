numbers = (1..20)

numbers.each do |number|
  if number % 3 == 0 && number % 5 == 0
    puts "FizzBazz"
  elsif number % 3 == 0
    puts "Fizz"
  elsif number % 5 == 0
    puts "Bazz"
  else
    puts number
  end
end
