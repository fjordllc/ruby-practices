#!/usr/bin/env ruby

score = ARGV[0]
splited_scores = score.split(',')

except_X_scores = splited_scores.map { |s| s == 'X' ? 10 : s.to_i }
p except_X_scores

# 結果の出力用配列
output_array = []

# 一時的な配列
tmp_array = []

except_X_scores.each do |num|
  if num == 10
    output_array << [num]
    tmp_array = []
  else
    tmp_array << num

    if tmp_array.size == 2
      output_array << tmp_array
      tmp_array = []
    end
  end
end

p output_array

result_array = []

output_array.each_with_index do |array, i|
  if array.length == 2 && array.sum == output_array.length && i != output_array.length - 1
    result_array << array.push(output_array[i + 1][0])
  elsif array.length == 1 && array[0] == 10
    result_array << array + output_array[i + 1].take(2)
  else
    result_array << array
  end
end
p result_array