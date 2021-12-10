require_relative 'lib/fizzbuzz'

def result
  puts fizzbuzz
end
def fizzbuzz
  include Fizzbuzz
  Fizzbuzz.build
end

result
