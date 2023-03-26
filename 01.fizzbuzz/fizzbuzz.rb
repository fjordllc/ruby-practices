def fizz(num)
    "Fizz" if num%3 == 0
end

def buzz(num)
    "Buzz" if num%5 == 0
end

def fizzbuzz(max_count)
    (1..max_count).each{ | n |
        if (fizz(n) || buzz(n)) != nil
            puts ("#{fizz(n)}#{buzz(n)}")
        else
            puts n
        end
    }
end

fizzbuzz(20)
