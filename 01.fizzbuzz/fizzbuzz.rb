def fizzbuzz
  (1..20).each do|num|
    if num % 15 == 0
      p "FizzBuzz"
    elsif num % 3 == 0
      p "Fizz"
    elsif num % 5 == 0
      p "Buzz"
    else
      puts num
    end
  end
end

fizzbuzz
