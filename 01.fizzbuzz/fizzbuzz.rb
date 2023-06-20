## checked fizzbuzz
def fizzbuzz(x)
  if x % 3 == 0
    return "Fizz"
  elsif x % 5 == 0
    return "Buzz"
  elsif x % 15 == 0
    return "FizzBuzz"
  else
    return x.to_s
  end
end

## view
(1..20).each do |num|
  puts fizzbuzz(num)
end
