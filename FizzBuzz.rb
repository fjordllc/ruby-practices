(1..20).each do |number|
  case
  when number % 15 == 0
    puts "FizzBuzz"
  when number % 5 == 0
    puts "Buzz"
  when number % 3 == 0
    puts "Fizz"
  else
    puts number
  end
end
