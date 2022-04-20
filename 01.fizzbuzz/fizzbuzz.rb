fizz = "Fizz"   # 3の倍数
buzz = "Buzz"   # 5の倍数

x = 1

while x <= 20
  if x % 15 == 0
    puts fizz + buzz

  else
    if x % 3 == 0
      puts fizz

    elsif x % 5 == 0
      puts buzz
    
    else
      puts x
    
    end
  end

  x += 1
end
