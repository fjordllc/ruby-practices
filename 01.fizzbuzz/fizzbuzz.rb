def pattern_selecter(num)
  multiple = 1
  if ((num % 3) == 0) && ((num % 5) ==0)
    multiple = 15
  elsif (num % 3) == 0
    multiple = 3
  elsif (num % 5) == 0
    multiple = 5
  end
  return multiple
end


20.times do |num|
  num += 1
  case pattern_selecter(num)
  when 15
    puts "FizzBuzz"
  when 3
    puts "Fizz"
  when 5
    puts "Buzz"
  else
    puts num
  end
end
