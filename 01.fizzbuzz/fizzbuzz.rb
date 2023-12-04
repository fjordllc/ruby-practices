#!/usr/bin/env ruby
(1..20).each do |num|
  fizzbuzz = ""
  fizzbuzz += "Fizz" if num%3 == 0
  fizzbuzz += "Buzz" if num%5 == 0
  if fizzbuzz.empty?
    puts num
  else
    puts fizzbuzz
  end
end