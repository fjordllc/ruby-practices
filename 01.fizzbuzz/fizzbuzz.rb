def fizzbuzz
(1..20).each do|num|
if num % 3 == 0
  puts "Fizz"
elsif num % 5 == 0
  puts "Buzz"
else
  puts num.to_s
end
end
end
fizzbuzz
