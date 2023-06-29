## checked fizzbuzz
def fizzbuzz(x)
  if x % 3 == 0
    "Fizz"
  elsif x % 5 == 0
    "Buzz"
  elsif x % 15 == 0
    "FizzBuzz"
  else
    x.to_s
  end
end

## view
(1..20).each do |num|
  puts fizzbuzz(num)
end
