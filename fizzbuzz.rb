(1..20).each do |x|
    if x % 15 == 0
        puts "fizzbuzz"
    elsif x % 5 == 0
        puts "buzz"
    elsif x % 3 == 0
        puts "fizz"
    else
        puts x
    end
end

