num = 0
while num < 20
  num = num + 1
  case
  when num % 3 == 0
    puts "Fizz"
  when num % 5 == 0
    puts "Buzz"
  when num % 3 == 0 || num%5 == 0
    puts "FizzBuzz"
  else
    puts num
  end
end
