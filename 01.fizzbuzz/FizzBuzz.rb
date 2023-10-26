#FizzBuzz課題

(1..20).each do |num|
    case
    when num % 15 == 0
      puts "#{num} FizzBuzz"
    when num % 3 == 0
      puts "#{num} Fizz"
    when num % 5 == 0
      puts "#{num} Buzz"
    else
      puts num
    end
  end
  