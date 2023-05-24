number = 0
while number <= 99
    number += 1
    if number % 3 == 0  && number % 5 != 0
        puts "fizz"
    elsif number % 5 == 0 && number % 3 != 0
        puts "bazz"
    elsif number % 3 == 0 && number % 5 == 0
        puts "fizzbazz"
    else
        puts number
    end
end
    