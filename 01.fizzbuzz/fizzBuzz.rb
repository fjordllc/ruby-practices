1.upto(20) do |count|
  if (count % 3).zero? && (count % 5).zero?
    puts 'FizzBuzz'
  elsif (count % 3).zero?
    puts 'fizz'
  elsif (count % 5).zero?
    puts 'buzz'
  else
    puts count
  end
end
