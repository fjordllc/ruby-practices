class FizzBuzz
  def run
    20.times do |n|
      if 0 == (n + 1) % 15
        puts "FizzBuzz"
      elsif 0 == (n + 1) % 5
        puts "Buzz"
      elsif 0 == (n + 1) % 3
        puts "Fizz"
      else
        puts (n + 1)
      end
    end
  end
end

FizzBuzz.new.run
