1.upto(20) do |sum|
    if sum % 15 == 0
        puts "FizzBuzz"
    elsif sum % 5 == 0
        puts "Buzz"
    elsif sum % 3 == 0
        puts "Fizz"
    else
        puts sum
    end
end
