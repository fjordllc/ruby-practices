# 1-20を表示する
numbers = [*1 .. 20]
numbers.each do |number|
    case
    # 3と5の倍数のときFizzBuzz
    when number / 5.to_f % 1 == 0 && number / 3.to_f % 1 == 0
        puts "FizzBuzz"
    # 3の倍数のときFizz
    when number / 3.to_f % 1 == 0
        puts "Fizz"
    # 5の倍数のときBuzz
    when number / 5.to_f % 1 == 0
        puts "Buzz"
    # それ以外のもの
    else
        puts number
    end
end