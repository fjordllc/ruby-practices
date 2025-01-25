count = 20 # カウントしたい回数
  
# FizzBuzzの判定
(1..count.to_i).each do |x|
  if x % 3 == 0 && x % 5 == 0
    puts "FizzBuzz"
  elsif x % 3 == 0
    puts "Fizz"
  elsif x % 5 == 0
    puts "Buzz"
  else
    puts x
  end
end
