a = (1..20).to_a

a.each do |x|
    x.to_i
    case x
    when x % 15 == 0 
        puts "FizzBuzz"
    when x % 3 == 0
        puts "Fizz"
    when x % 5 == 0
        puts "Buzz"
    else
        puts x
    end
end