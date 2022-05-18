def validate_number_of_arguments(stdin)
  unless stdin.length == 2
    puts "数値は2つ入力してください"
    exit
  end
end

def convert_to_integer(stdin)
  stdin.map! {|n| Integer(n)}
rescue => e
  puts "整数を入力してください - [#{e.message}]"
  exit
end

def check_fizzbuzz(number)
  return number if number.zero?

  if number % 3 == 0 && number % 5 == 0
    "FizzBuzz"
  elsif number % 3 == 0
    "Fizz"
  elsif number % 5 == 0
    "Buzz"
  else
    number
  end
end

def output_fizzbuzz(stdin)
  validate_number_of_arguments(stdin)
  convert_to_integer(stdin)
  first = stdin.sort!.shift
  last = stdin.shift

  number_range = Range.new(first, last)
  number_range.each {|n| puts check_fizzbuzz(n)}
end

stdin = ARGV
output_fizzbuzz(stdin)
