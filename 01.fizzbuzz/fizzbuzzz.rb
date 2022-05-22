(1..20).each do |num|
  if num % 3*5 == 0
    s = "FizzBuzz"
  elsif num % 3 == 0
    s = "Fizz"
  elsif num % 5 == 0
  s = "Buzz"
  else
    s = num.to_s
  end
  puts s
end