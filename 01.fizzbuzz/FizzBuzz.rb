#!/usr/bin/env ruby

# 1から20までの数をプリントするプログラムを書け。
# ただし3の倍数のときは数の代わりに｢Fizz｣と、5の倍数のときは｢Buzz｣とプリントし、
# 3と5両方の倍数の場合には｢FizzBuzz｣とプリントすること。

numbers = (1..20)
numbers.each do |number|
  case 
  when number%3 == 0 && number%5 == 0
    puts "FizzBuzz"
  when number%3 == 0
    puts "Fizz"
  when number%5 == 0
    puts "Buzz" 
  else
  puts number
  end
end
