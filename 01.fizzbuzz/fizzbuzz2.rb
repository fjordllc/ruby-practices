# なんか奇をてらおうとしてがんばったやつです

# 割り算を一旦float にして、それを string にして少数点以下が ".0" だったらFizzBuzz言う
def eval_string(x, y)
  (x / y.to_f).to_s.slice(/\..*/) == ".0"
end

(1..20).each do |x|
  if eval_string(x, 5) &&  eval_string(x, 3)
    p "FizzBuzz"
  elsif eval_string(x, 5)
    p "Buzz"
  elsif eval_string(x, 3)
    p "Fizz"
  else
    p x
  end
end
