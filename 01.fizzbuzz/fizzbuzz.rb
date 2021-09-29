numbers = 1..20
numbers.each do |number|
    if  number % 15 == 0
        puts "FizzBuzz"
        next
    elsif number % 3 == 0
        puts "Fizz"
        next
    elsif number % 5 == 0
        puts "Buzz"
        next
    end
    puts number
end
