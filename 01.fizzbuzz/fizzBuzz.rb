20.times do |count|
  count += 1
  case 
  when count % 15 == 0
    puts "FizzBuzz"
  when count % 3 == 0
    puts "Fizz"
  when count % 5 == 0
     puts "Buzz"
  else
    puts count
  end
end