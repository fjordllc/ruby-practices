#!/usr/bin/env ruby

number = (1..100)
number.each{|n|
    if  (n % 15 == 0)
        n = "FizzBuzz"
    elsif (n % 5 == 0)
        n = "Buzz"
    elsif (n % 3 == 0)
        n = "Fizz"
    end
    puts "#{n}"
}
