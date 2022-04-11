sum = 0
20.times do
  sum += 1
  if sum/15.0 == 1
    puts "FizzBuzz"
    next
  elsif sum/3.0 == (1.0) .. (20.0)
    puts "Fizz"
    next
  elsif sum/5.0 == 1||sum/5.0 == 2||sum/5.0 == 3||sum/5.0 == 4
    puts "Buzz"
    next
  end
  puts sum
end
