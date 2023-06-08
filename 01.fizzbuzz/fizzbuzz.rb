## checked fizzbuzz
def fizzbuzz_checked(x)
  return "FizzBuzz" if x % 15 == 0
  return "Fizz" if x % 3 == 0
  return "Buzz" if x % 5 == 0
end

## view
(1..20).each do |num|
  case fizzbuzz_checked(num)
  when "FizzBuzz"
    puts "FizzBuzz"
  when "Fizz"
    puts "Fizz"
  when "Buzz"
    puts "Buzz"
  else
    puts num
  end
end
