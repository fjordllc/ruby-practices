range = 1..20  #表示される数字の範囲を設定

#数字を順番に表示
range.each do |n|
  if n % 3 == 0
    puts "Fizz"
  
  else 
    puts n
  end
end

