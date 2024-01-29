#!/usr/bin/ruby

def fizzbuzz
  (1..20).each do |n|
    output = ''
    output = 'Fizz' if n % 3 == 0   # 3の倍数なら Fizz を出力
    output += 'Buzz' if n % 5 == 0  # 5の倍数なら Bizz を出力
    output = n if output.empty?     # 上記どちらでもなければ数字を出力
    puts output
  end
end

fizzbuzz