
# 表示・評価したいMaxの数値を入力
num = 20

# 3の倍数でFizz、5の倍数でBuzz、両方でFizzBuzzを表示
num.times{|i| 
    if (i+1)%15 === 0
        result = 'FizzBuzz'
    elsif (i+1)%5 === 0
        result = 'Buzz'
    elsif (i+1)%3 === 0
        result = 'Fizz'
    else 
        result = i+1
    end
    puts result
}
