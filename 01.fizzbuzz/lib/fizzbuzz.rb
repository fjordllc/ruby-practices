def fizz_buzz(num)
  if (num % 15).zero?
    'FizzBuzz'
  elsif (num % 5).zero?
    'Buzz'
  elsif (num % 3).zero?
    'Fizz'
  else
    num.to_s
  end
end
