class Fizzbuzz

    def puts_fizzbuzz()
        for num in 1 .. 20
            if num % 3 == 0 && num % 5 == 0
                puts "FizzBuzz"
            elsif num % 3 == 0
                puts "Fizz"
            elsif num % 5 == 0
                puts "Buzz"
            else
                puts num
            end
        end 
    end
end

Fizzbuzz.new().puts_fizzbuzz()
