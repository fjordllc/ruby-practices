num_first = 1
num_last = 20

num_array = (num_first..num_last).to_a
num_array.each do |num|
   if  num % 3 == 0 && num % 5 == 0
    puts "Fizz"
    puts "Buzz"
   elsif num % 3 == 0
    puts "Fizz"
   elsif num % 5 == 0
    puts "Buzz"
   else
    puts num
   end