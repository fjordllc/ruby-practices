num = 1
while num <= 20
    if num % 15 == 0
        print "FizzBuzz\n"
        num = num +1
    elsif num % 5 == 0
        print "Buzz\n"
        num = num +1
    elsif num % 3 == 0
        print "Fizz\n"
        num = num +1   
    else
        print "#{num}\n"
        num = num +1
    end   
end
