range = 1..20  #表示される数字の範囲を設定

#数字を順番に表示
#3の倍数なら"Fizz"を表示
#5の倍数なら"Buzz"を表示
range.each do |n|
  if n % 3 == 0
    puts "Fizz"
  elsif n % 5 == 0
    puts "Buzz"
  else
    puts n
  end
end

