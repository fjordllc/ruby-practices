n = 0
while n < 20
    n += 1
    if n % 3 == 0 && n % 5 == 0
        puts "FizzBuzz"
    elsif n % 3 == 0 
        puts "Fizz"
    elsif n % 5 == 0
        puts "Buzz"
    else
        puts n
    end
end

