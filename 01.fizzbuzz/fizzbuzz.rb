i = 1
while i <= 20
  result = ""
  result = "fizz" if i % 3 == 0
  result = "#{result}buzz" if i % 5 == 0
  result = i if result == ""
  puts result
  i += 1
end
