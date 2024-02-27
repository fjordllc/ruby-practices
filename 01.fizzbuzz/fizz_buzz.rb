num = 0
20.times do
    num += 1
    if num % 15 == 0
        puts "FizzBuzz"
    elsif num % 5 == 0
        puts "Buzz"
    elsif num % 3 == 0
        puts "Fizz"
    else
        puts num
    end
end

# num = 0
# 20.times do
#     num += 1
#     case num
#     when num % 15 == 0
#         puts "FizzBuzz"
#     when num % 5 == 0
#         puts "Buzz"
#     when num % 3 == 0
#         puts "Fizz"
#     else
#         puts num
#     end
# end
