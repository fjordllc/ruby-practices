numbers = (1..20).to_a
numbers.each{|number| 
    if number % 15.0 == 0
        puts "FizzBuzz"
    elsif number % 3.0 == 0
        puts "Fizz"
    elsif number % 5.0 == 0
        puts "Buzz"
    else 
        puts number
    end
}
