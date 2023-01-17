1.upto(20) do |num|
  case 
    when num % 15 == 0 then puts "FizzBuzz"
    when num % 3 == 0  then puts "Fizz"
    when num % 5 == 0  then puts "Buzz"
    else puts num
  end
end