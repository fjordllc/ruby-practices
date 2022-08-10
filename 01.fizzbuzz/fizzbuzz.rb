x = 1
while x <= 20
    if x % 15 == 0
        puts "Fizz Buzz"
    elsif x % 3 == 0
        puts "Fizz"
    elsif x % 5 == 0
        puts "Buzz"
    else
        puts x
    end
    x += 1
end


