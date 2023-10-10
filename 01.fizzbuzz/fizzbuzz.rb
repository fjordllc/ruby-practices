#!/usr/bin/env ruby

def fizz(x)
    return "Fizz" if x % 3 == 0
    return ""
end

def buzz(x)
    return "Buzz" if x % 5 == 0
    return ""
end

(1..20).each do |x|
    if x % 3 == 0 || x % 5 == 0
        puts fizz(x) + buzz(x)
    else
        puts x
    end
end

