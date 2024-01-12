20.times do |number
  true_number = number + 1
  if true_number %  15 == 0
    puts "FizzBuzz"
  elsif true_number %  3 == 0
    puts "Fizz"
  elsif true_number %  5 == 0
    puts "Buzz"
  else
    puts true_number
  end
end

