x = 1
while x <= 20
    if x % 15 == 0
        puts "fizz buzz"
    elsif x % 3 == 0
        puts "fizz"
    elsif x % 5 == 0
        puts "buzz"
    else
        puts x
    end
    x += 1
end
