(1..20).each do |x|
  if x % 15 == 0 # 15の倍数
    puts "Fizz Buzz"
  elsif x % 3 == 0 # 3の倍数
    puts "Fizz"
  elsif x % 5 == 0 # 5の倍数
    puts "Buzz"
  else
    puts x
  end
end
