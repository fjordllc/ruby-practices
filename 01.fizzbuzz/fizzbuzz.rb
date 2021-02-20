def fizzbuzz(max_number)
  1.upto(max_number) do |number|
    if number % 15 == 0
      puts "fizzbuzz"
    elsif number % 5 == 0
      puts "buzz"
    elsif number % 3 == 0
      puts "fizz"
    else
      puts number
    end
  end
end

max_number = 100
fizzbuzz(max_number)
