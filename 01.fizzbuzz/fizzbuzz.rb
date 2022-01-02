(1..20).each { |i|
  if i % 15 == 0
    puts "FizzzBuzz"
  elsif i % 3 == 0
    puts "Fizz"
  elsif i % 5 == 0 
    puts "Buzz"
  else
    puts i
  end
}