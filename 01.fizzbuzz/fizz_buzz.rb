(1..20).each do |num|
  output = case
    when (num % 15).zero? then "FizzBuzz"
    when (num % 3).zero? then "Fizz"
    when (num % 5).zero? then "Buzz"
    else num
  end

  puts output
end

