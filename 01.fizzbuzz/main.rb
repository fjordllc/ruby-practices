

def fizzbuzz(n)
  if !(n.is_a? Integer)
    raise "#{n} is not Integer"
  end

  answer = ""
  if n % 3 == 0
    answer += "Fizz"
  end
  if n % 5 == 0
    answer += "Buzz"
  end

  return answer == "" ? n.to_s : answer
end


(1..20).each do |n|
  puts fizzbuzz(n)
end
