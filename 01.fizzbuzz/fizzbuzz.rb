20.times.each { |num|
  if (num+1) % 3 == 0 && (num+1) % 5 == 0
    puts "FizzBuzz"
  elsif (num+1) % 3 == 0
    puts "Fizz"
  elsif (num+1) % 5 == 0
    puts "Buzz"
  else
    puts (num+1)
  end
}
