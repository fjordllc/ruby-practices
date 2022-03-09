for n in (1..20) do
  if n % 3 == 0 && n % 5 == 0 then
    puts "FizzBuzz"
  elsif n % 3 == 0 then
    puts "Fizz"
  elsif n % 5 == 0 then
    puts "Buzz"
  else
    puts n
  end
end
