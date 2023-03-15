# FizzBuzz問題
(1..20).each do |i|
  # 15の倍数のときは"FizzBuzz"を表示
  if i % 15 == 0
    puts "FizzBuzz"

  # 3の倍数のときは"Fizz"を表示    
  elsif i % 3 == 0
    puts "Fizz"

  # 5の倍数のときは"Buzz"を表示
  elsif i % 5 == 0
    puts "Buzz"

  # それ以外は、数を表示  
  else
    puts i
 end
end
