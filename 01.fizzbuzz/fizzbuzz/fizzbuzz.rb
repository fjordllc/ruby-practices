i = 0
100.times do
  i += 1
  if i % 3 == 0 && i % 5 == 0 then
    puts "FizzBuzz"
  elsif i % 3 == 0 then
    puts "Fizz"
  elsif i % 5 == 0 then
    puts "Buzz"
  else
    puts i
  end
end

