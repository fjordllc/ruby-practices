# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
scores = opt.parse(ARGV)[0].split(',')

total = 0
frame = 1
second = false

scores.map! { |i| i == 'X' ? 10 : i }

scores.each_with_index do |score, index|
  if score == 10
    total += 10
    total += scores[index + 1].to_i + scores[index + 2].to_i unless frame >= 10
    second = false
    frame += 1
  else
    total += score.to_i
    if second == false
      second = true
    else
      total += scores[index + 1].to_i if scores[index - 1].to_i + score.to_i == 10 && frame < 10
      second = false
      frame += 1
    end
  end
end

puts total
