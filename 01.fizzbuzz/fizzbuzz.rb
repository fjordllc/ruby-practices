bango = 1
while bango <= 20
  if bango%3 == 0 and bango%5 == 0
    puts "FizzBuzz"
  elsif bango%3 == 0
    puts "Fizz"
  elsif bango%5 == 0
    puts "Buzz"
  else
    puts bango
  end
  bango += 1
end
