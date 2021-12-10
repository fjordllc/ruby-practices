require_relative 'fizzbuzz'

RSpec.describe  do
  # Todo:下記のtextの定義をもっとシンプルにしたい
  text = <<TEXT
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
16
17
Fizz
19
Buzz
TEXT
  it '#result' do
    expect{result}.to output(text).to_stdout
  end
end

