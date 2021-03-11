# %で割り切れるかどうか調べて判別する方法
num_array = [*1..20]

num_array.each do |f|
  result = ''

  result << 'Fizz' if f / 3 >= 1 && f % 3 == 0
  result << 'Buzz' if f / 3 >= 1 && f % 5 == 0
  result << f.to_s if f % 3 != 0 && f % 5 != 0

  puts result
end
