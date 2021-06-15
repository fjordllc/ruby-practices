(1..20).each do |i|
if i % 3 == 0
    puts "fizz"
elsif i % 5 == 0
    puts "buzz"
elsif i % 3 == 0 && num % 5 == 0
    puts "fizzbuzz"
else puts i
end
end
