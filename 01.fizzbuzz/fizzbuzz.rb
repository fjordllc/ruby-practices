(1..50).each do |a|
    if a%15==0
        puts "fizzbuzz"
    elsif a%3==0
        puts "fizz"
    elsif a%5==0
        puts "buzz"
    else
        puts a   
    end
end

