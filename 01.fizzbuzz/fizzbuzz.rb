num =1
loop{
  case
  when num%15==0
    puts "FizzBuzz"
  when num%3==0
      puts "Fizz"
  when num%5==0
      puts "Buzz"
  else
      puts num
  end
  num+=1
  if num > 20
    break
  end
}
