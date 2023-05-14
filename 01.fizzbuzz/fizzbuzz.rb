fizzbuzz = 0
while fizzbuzz < 20
  fizzbuzz = fizzbuzz + 1
  if fizzbuzz % 15 == 0
    puts "Fizzbuzz"
  elsif fizzbuzz % 3 == 0 && fizzbuzz % 5 != 0
    puts "Fizz"
  elsif fizzbuzz % 3 != 0 && fizzbuzz % 5 == 0
    puts "Buzz"
  else fizzbuzz % 3 != 0 && fizzbuzz % 5 != 0
    puts fizzbuzz
  end
end
