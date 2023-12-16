(1..20).each do |x|
    if x % 3==0 && x % 5!=0
        p "Fizz"
    elsif x % 5==0 && x % 3!=0
        p "Buzz"
    elsif x % 3==0 && x % 5==0
        p "FizzBuzz"
    else
        p x
    end
end
