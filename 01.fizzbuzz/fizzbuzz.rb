def fizzbuzz(number1=3, number2=5, max_count=20)
    max_count.times do |i|
        i += 1
        common_multiple = number1*number2
        case
        when i%common_multiple == 0
            puts 'FizzBuzz'
        when i%number1 == 0
            puts 'Fizz'
        when i%number2 == 0
            puts 'Buzz'
        else
            puts i
        end
    end
end

fizzbuzz
