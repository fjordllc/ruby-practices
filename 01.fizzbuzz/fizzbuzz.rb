for i in 1..20
    is_multiple_of_3 = i % 3
    is_multiple_of_5 = i % 5

    if is_multiple_of_3 == 0 && is_multiple_of_5 == 0
        puts "FizzBuzz"
    elsif is_multiple_of_3 == 0 && is_multiple_of_5 != 0
        puts "Fizz"
    elsif is_multiple_of_3 != 0 && is_multiple_of_5 == 0
        puts "Buzz"
    else
        puts i
    end
end