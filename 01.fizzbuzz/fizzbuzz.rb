numbers = []
x = 0
while x < 100
  x += 1
  numbers.push(x)
end

numbers.each do |x|
  if x % 5 == 0 && x % 3 == 0
    puts "fizzbuzz"
  else
    if x % 5 == 0
      puts "buzz"
    else
      if x % 3 == 0
        puts "fizz"
      else
        puts x
      end
    end
  end
end