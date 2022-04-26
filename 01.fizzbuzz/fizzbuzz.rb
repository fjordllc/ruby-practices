#x = 1 #ローカル変数は基本使わない

#while x <= 20

(1..20).each do |x|
  if x % 15 == 0 # 15の倍数
    puts "Fizz" + "Buzz"
  elsif x % 3 == 0 # 3の倍数
    puts "Fizz"
  elsif x % 5 == 0 # 5の倍数
    puts "Buzz"
  else
    puts x
  end
  x += 1
end
