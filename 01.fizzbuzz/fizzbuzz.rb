for i in 1..20
  if i % 15 == 0
    p "FizzBuzz"
  elsif i % 3 == 0
    p "Fizz"
  elsif i % 5 == 0
    p "Buzz"
  else
    p i
  end
end
