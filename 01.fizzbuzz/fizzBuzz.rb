# 20.times do |count|
#   count += 1
#   case 
#   when count % 15 == 0
#     puts "FizzBuzz"
#   when count % 3 == 0
#     puts "Fizz"
#   when count % 5 == 0
#      puts "Buzz"
#   else
#     puts count
#   end
# end

# 20.times do |count|
#   count += 1
#   puts "FizzBuzz" if count % 15 == 0
#   puts "Fizz" if count % 3 == 0 && count % 15 != 0
#   puts "Buzz" if count % 5 == 0 && count % 15 != 0
#   puts count if count % 3 != 0 && count % 5 != 0
# end

# 20.times do |count|
#   count += 1
#   if count % 15 == 0
#     puts "FizzBuzz"
#     next
#   end
#   # puts "FizzBuzz" next if count % 15 == 0
#   puts "Fizz" if count % 3 == 0
#   puts "Buzz" if count % 5 == 0
#   puts count if count % 3 != 0 && count % 5 != 0
# end

# 1.upto(20) do |count|
#   puts "FizzBuzz" if count % 15 == 0
#   puts "Fizz" if count % 3 == 0 && count % 15 != 0
#   puts "Buzz" if count % 5 == 0 && count % 15 != 0
#   puts count if count % 3 != 0 && count % 5 != 0
# end

1.upto(20) do |count|
  p "FizzBuzz" if count % 15 == 0
  p "Fizz" if count % 3 == 0 && count % 15 != 0
  p "Buzz" if count % 5 == 0 && count % 15 != 0
  p count if count % 3 != 0 && count % 5 != 0
end