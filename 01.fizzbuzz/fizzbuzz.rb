## checked fizzbuzz
def fizzbuzz(x)
  return "FizzBuzz" if x % 15 == 0
  return "Fizz" if x % 3 == 0
  return "Buzz" if x % 5 == 0
end

## view
(1..20).each do |num|
  if fizzbuzz(num)
    puts fizzbuzz(num)
  else
    puts num
  end
end
