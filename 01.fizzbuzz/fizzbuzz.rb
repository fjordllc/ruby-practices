(1..20).each{|n|
  if n % 15 == 0
    print "FizzBuzz\n"
  elsif n % 3 == 0
    print "Fizz\n"
  elsif n % 5 == 0
    print "Buzz\n"
  else
    printf("%d\n", n)
  end
}
