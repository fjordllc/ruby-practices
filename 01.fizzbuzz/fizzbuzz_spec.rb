require_relative "./fizzbuzz"

describe "fizzbuzz" do
  context "引数が20の場合" do
    let(:size) { 20 }
    example do
      expect {
        fizzbuzz(size: size)
      }.to output(
        <<~MSG
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
        MSG
      ).to_stdout
    end
  end

  context "引数が45の場合" do
    let(:size) { 45 }
    example do
      expect {
        fizzbuzz(size: size)
      }.to output(
        <<~MSG
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
        Fizz
        22
        23
        Fizz
        Buzz
        26
        Fizz
        28
        29
        FizzBuzz
        31
        32
        Fizz
        34
        Buzz
        Fizz
        37
        38
        Fizz
        Buzz
        41
        Fizz
        43
        44
        FizzBuzz
        MSG
      ).to_stdout
    end
  end

end
