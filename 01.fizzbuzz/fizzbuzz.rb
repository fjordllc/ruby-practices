# 1 ~ 15の間で任意の数字を格納
number = [*1..15].sample

# 3の倍数、5の倍数、それ以外の数字それぞれの処理
remainder_3 = number % 3
remainder_5 = number % 5
answer = ""

if remainder_3 == 0
    answer += "Fizz"
end
if remainder_5 == 0
    answer += "Buzz"
end
if answer == ""
    answer = number
end

# 結果を表示
puts answer
