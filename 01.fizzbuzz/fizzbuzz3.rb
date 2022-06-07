# 一番最初に書いたやつ

(1..20).each do |x|
  if x % 3 == 0 && x % 5 ==0
    p "FizzBuzz"
  elsif x % 3 == 0
    p "Fizz"
  elsif x % 5 == 0
    p "Buzz"
  else
    p x
  end
end
