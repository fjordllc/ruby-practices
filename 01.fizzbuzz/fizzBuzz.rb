1.upto(20) do |count|
  if (count % 3).zero? && (count % 5).zero?
    puts 'FizzBuzz'
  elsif (count % 3).zero?
    puts 'Fizz'
  elsif (count % 5).zero?
    puts 'Buzz'
  else
    puts count
  end
end
