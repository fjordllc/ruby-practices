#!/usr/bin/env ruby

# 1から20までの数をプリントするプログラムを書け。
# ただし3の倍数のときは数の代わりに｢Fizz｣と、5の倍数のときは｢Buzz｣とプリントし、3と5両方の倍数の場合には｢FizzBuzz｣とプリントすること。
# $ ./fizzbuzz.rb 
# 1
# 2
# Fizz
# 4
# Buzz
# Fizz
# 7
# 8
# Fizz
# Buzz
# 11
# Fizz
# 13
# 14
# FizzBuzz
# 16
# 17
# Fizz
# 19
# Buzz

# Fizz Buzz FizzBuzzを判定するメソッド 判定する数値とFizzとBuzzの倍数を引数に取る
def fizz_buzz( num, fizz_num, buzz_num )
  if num % fizz_num == 0
    if num % buzz_num == 0
        puts "FizzBuzz"
    else 
        puts "Fizz"
    end 
  elsif num % buzz_num == 0
    puts "Buzz"
  else 
    puts num
  end
end

fizz_num = 3
buzz_num = 5
rep_num = 50

for num in 1..rep_num
  fizz_buzz(num,fizz_num,buzz_num)
end
