(1..20).each{|n|
  if n % 3 == 0
    print "Fizz "
  elsif n % 5 == 0
    print "Buzz "
  elsif n % 15 == 0
  print "FizzBuzz "
  else
    printf("%d ", n)
  end
}
