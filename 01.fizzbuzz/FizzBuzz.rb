# 初期値を0にする
x=0

# xが20になるまで,xに1ずつ足して、条件分岐させるwhile構文を作成する。
while x<20
  # 変数x（初期値==0）に１ずつ足していく
  x=x+1
  # 3の倍数かつ5の倍数の時、FizzBuzzと表示
  if x%3==0 && x%5==0
    puts "FizzBuzz"
  # 5の倍数の時、Buzzと表示
  elsif x%5==0
    puts "Buzz"
  # 3の倍数の時、Fizzと表示
  elsif x%3==0
    puts "Fizz"
  # それ以外はxを表示
  elsif
    puts x
  end
end
  