(1..20).each do |n|
  if n % 15 == 0
    puts 'FizzBuzz'
  elsif n % 5 == 0
    puts 'Buzz'
  elsif n % 3 == 0
    puts 'Fizz'
  else 
    puts n
  end
end
