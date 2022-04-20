fizzbuzz = 0
while fizzbuzz < 20
  fizzbuzz += 1
  if fizzbuzz % (3*5) == 0
    puts 'fizzbuzz'
  elsif fizzbuzz % 3 == 0
    puts "fizz"
  elsif fizzbuzz % 5 == 0
    puts "buzz"
  else
    puts fizzbuzz
  end
end
