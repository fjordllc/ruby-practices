class FizzBuzz
    def fizzbuzz(number)
        if number % 15 == 0
            puts "FizzBuzz"
        elsif number % 5 == 0
            puts "Buzz"
        elsif number % 3 == 0
            puts "Fizz"
        else
            puts number
        end
    end
end

fizz_buzz_instance = FizzBuzz.new
repeat_count = 20
repeat_count.times.each do |number|
    fizz_buzz_instance.fizzbuzz(number + 1)
end