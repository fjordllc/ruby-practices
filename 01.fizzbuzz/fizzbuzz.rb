x = 0
20.times do 
  x += 1
  if x % 3 == 0 && x % 5 == 0
    puts "FizzBuzz"
  elsif  
    x % 3 == 0
    puts "Fizz"
  elsif  x % 5 == 0
    puts "Buzz"
  else
    puts x
  end
end
