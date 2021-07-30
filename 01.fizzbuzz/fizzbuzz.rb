i = 1
20.times do
  if (i % (3 * 5)) == 0
    puts "FizzBuzz"
  elsif (i % 3) == 0
    puts "Fizz"
  elsif (i % 5) == 0
    puts "Buzz"
  else
    puts i
  end
  i += 1
end
