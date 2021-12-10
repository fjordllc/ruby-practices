a = 0 # 0からスタート
while a < 20 # 1から20までの数字を書く
  a += 1 # 「a = a + 1」の省略形
  unless a % 3 == 0 || a % 5 == 0 # 3の倍数でも5の倍数でもないの時は
    puts a
  end  
  if a % 3 == 0 && a % 5 != 0 # 3の倍数かつ、5の倍数でない時は
    puts "Fizz"
  end
  if a % 5 == 0 && a % 3 != 0 # 5の倍数かつ、3の倍数でない時は
    puts "Buzz"
  end
  if a % 3 == 0 && a % 5 == 0 # 3の倍数かつ5の倍数の時は
    puts "FizzBuzz"
  end
end
