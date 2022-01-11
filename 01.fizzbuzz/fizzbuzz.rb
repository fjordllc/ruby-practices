def fizzbuzz(num)
  if num % 15 == 0
    return "FizzBuzz"
  end

  if num % 5 == 0
    return "Buzz"
  end

  if num % 3 == 0
    return "Fizz"
  end

  return num
end

(1..20).each do |x|
  puts fizzbuzz(x)
end
