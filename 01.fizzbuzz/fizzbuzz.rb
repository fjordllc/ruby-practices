#!/usr/bin/env ruby

(1..20).each do | x |
  op = ""
  op << "Fizz" if x%3 == 0
  op << "Buzz" if x%5 == 0
  op = x.to_s if op == ""
  puts op
end

