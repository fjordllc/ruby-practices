#変数を準備
number_s = 0
multiple_3 = 0
multiple_5 = 0

#繰り返し処理
while number_s <= 19
    number_s += 1
    multiple_3 = number_s % 3
    multiple_5 = number_s % 5
    if multiple_3 == 0 && multiple_5 == 0
    puts "FizzBuzz"
    elsif multiple_3 == 0
    puts "Fizz"
    elsif  multiple_5 == 0
    puts "Buzz" 
    else
    puts number_s
    end
end