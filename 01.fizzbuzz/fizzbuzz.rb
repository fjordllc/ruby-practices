def fizzbuzz
  (1..20).each do |n|
    case
    when n % 3 == 0 && n % 5 == 0 then
      puts 'Fizzbuzz'
    when n % 3 == 0 then
      puts 'Buzz'
    when n % 5 == 0 then
      puts 'Buzz'
    else
      puts n
    end
  end
end

fizzbuzz
