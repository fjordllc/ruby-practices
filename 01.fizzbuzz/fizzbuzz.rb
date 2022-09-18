#fizzbuzz
number = 0
while number <= 20
    number = number + 1
    if number % 15 == 0
        puts "FizzBuzz"
    elsif number % 3 == 0
        puts "Buzz"
    elsif number % 5 == 0
        puts "Fizz"
    else
        puts number
    end
end
