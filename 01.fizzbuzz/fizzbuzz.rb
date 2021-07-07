# 何の倍数にするか
x = 3
y = 5

# 数字の範囲
min = 1
max = 20

# 出力する言葉
# xの倍数の時
word_x = "Fizz"
# yの倍数の時
word_y = "Buzz"
# xの倍数かつyの倍数の時
word_xy = word_x + word_y

(min..max).each do |num|
  if num % x == 0 && num % y == 0
    puts word_xy
  elsif num % x == 0
    puts word_x
  elsif num % y == 0
    puts word_y
  else
    puts num
  end
end
