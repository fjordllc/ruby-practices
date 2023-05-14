fizzbuzz = 0
while fizzbuzz < 20
  fizzbuzz = fizzbuzz + 1
  if fizzbuzz % 15 == 0 then
    puts "Fizzbuzz"
  elsif fizzbuzz % 3 == 0 && fizzbuzz % 5 != 0 then
    puts "Fizz"
  elsif fizzbuzz % 3 != 0 && fizzbuzz % 5 == 0 then
    puts "Buzz"
  else
    puts fizzbuzz
  end
end