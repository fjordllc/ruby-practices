#!/usr/bin/env ruby

def fizzbuzz(size: 20)
  [*1 .. size].each do |num|
    words = []
    words.push("Fizz") if num % 3 == 0
    words.push("Buzz") if num % 5 == 0
    words.push(num.to_s) if words.empty?
    puts words.join("")
  end
end

fizzbuzz(size: 20) if $0 == __FILE__
