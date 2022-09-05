num = 0
while  num < 20
  num = num + 1

  if num % 3 == 0  && num % 5 == 0 then 
    puts "FizzBuzz"
    next
  end

  if num % 3 == 0 then
    puts "Fizz"
    next
  end

  if num % 5  == 0 then
    puts "Buzz"
    next
  end

  puts num
end
