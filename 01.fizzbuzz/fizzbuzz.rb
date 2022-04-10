sum = 0
20.times do
  sum += 1
  if sum/15.0 == 1
    puts "FizzBuzz"
    next
  elsif sum/3.0 == 1||sum/3.0 == 2||sum/3.0 == 3||sum/3.0 == 4||sum/3.0 == 5||sum/3.0 == 6
    puts "Fizz"
    next
  elsif sum/5.0 == 1||sum/5.0 == 2||sum/5.0 == 3||sum/5.0 == 4
    puts "Buzz"
    next
  end
  puts sum
end
