fizzbuzz = 0
while fizzbuzz < 20
    fizzbuzz = fizzbuzz + 1
    if fizzbuzz % 3 == 0 && fizzbuzz % 5 == 0
        puts "Fizzbuzz"
    end
    if fizzbuzz % 3 == 0 && fizzbuzz % 5 != 0
        puts "Fizz"
    end
    if fizzbuzz % 3 != 0 && fizzbuzz % 5 == 0
        puts "Buzz"
    end
    if fizzbuzz % 3 != 0 && fizzbuzz % 5 != 5
        puts fizzbuzz
    end
end
