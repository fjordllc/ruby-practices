[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20].map do |x|
  if x %3 == 0 && x %5 == 0
    puts "FizzBuzz"
  elsif x %3 == 0
    puts "Fizz"
  elsif x %5 == 0
    puts "Buzz"
  elsif
    puts x
  end
end
