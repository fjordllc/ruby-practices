number = 1..20
number.each do |count|
  if count%3==0 && count%5==0
    puts 'Fizz Buzz'
  elsif  count%3==0
    puts 'Fizz'
  elsif  count%5==0
    puts 'Buzz'
  else
    puts count
  end
end
