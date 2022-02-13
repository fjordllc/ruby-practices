default = 0
20.times do
    default += 1
    if default % 3 == 0 && default % 5 == 0
    puts 'FizzBuzz'
    elsif default % 3 == 0
        puts 'Fizz'
    elsif default % 5 == 0
        puts 'Buzz'
    else
        puts default
    end
end
