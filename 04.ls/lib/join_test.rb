class String
  def size_jp
    count = 0
    self.each_char do |char|
      if char.match?(/\p{Han}|\p{Hiragana}|\p{Katakana}/)
        count += 2
      else
        count += 1
      end
    end
    count
  end

  def ljust_jp(max_size)
    self + ' ' * (max_size - self.size_jp)
  end
end


def join_with_aligned_elements(two_dimensional_array)
  max_length = two_dimensional_array.flatten.map(&:size_jp).max
  puts max_length

  two_dimensional_array.map do |sub_array|
    sub_array.map do |str|
      p str.ljust_jp(max_length) 
      str.ljust_jp(max_length) 
    end.join(" ")
  end.join("\n")
end

array = [
  ["abc", "def"],
  ["あいう", "江尾"]
]

result = join_with_aligned_elements(array)
puts result
