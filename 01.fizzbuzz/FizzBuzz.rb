range = 1 .. 20

range.each{|num|
    if num % (3 * 5) == 0
        puts("FizzBuzz")
    elsif num % 3 == 0
        puts("Fizz") 
    elsif num % 5 == 0
        puts("Buzz") 
    else
        puts(num)
   end

}
