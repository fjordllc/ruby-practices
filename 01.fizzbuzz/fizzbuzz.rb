#! /usr/bin/env ruby
x = 0
while x < 20
    x = x + 1
    if x.modulo(3) == 0
        puts "fizz"
    elsif x.modulo(5) == 0
        puts "buzz"
    elsif x.modulo(3) == 0 && x.modulo(5) == 0
        puts "fizzbuzz"
    else
        puts x.to_s
    end
end
