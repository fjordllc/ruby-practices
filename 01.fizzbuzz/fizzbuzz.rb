@fizzbuzz = {fizz: 3, buzz: 5}

# 除算の結果が1増えるタイミングでFizzBuzz言う
def timing(x, y)
  x / y - (x - 1) / y == 1
end

# FizzBuzz言うときの動き
def call(x)
  @fizzbuzz.each do |key, value|
    if timing(x, value)
      print key.capitalize
    end
  end
end

# FizzBuzz 言ってもいいかどうか判定
def checker(x)
  @fizzbuzz.each_value do |v|
    if timing(x, v)
      return true
    end
  end
end

(1..20).each do |x|
  if checker(x) == true
    call(x)
  else
    print x
  end
  print "\n"
end
