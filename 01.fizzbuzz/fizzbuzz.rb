1.upto(20) do |index|
    if index % 15 == 0
        puts "FizzBuzz"
    elsif index % 5 == 0
        puts "Buzz"
    elsif index % 3 == 0
        puts "Fizz"
    else
        puts index
    end
end
