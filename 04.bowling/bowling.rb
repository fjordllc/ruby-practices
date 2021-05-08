# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
score = opt.parse(ARGV)[0].split(',')

total = 0
frame = 1
second = false

score.map! { |i| i == 'X' ? 10 : i }

score.each_with_index do |pins, index|
  if pins == 10
    total += 10
    total += score[index + 1].to_i + score[index + 2].to_i unless frame >= 10
    second = false
    frame += 1
  else
    total += pins.to_i
    if second == false
      second = true
    else
      total += score[index + 1].to_i if score[index - 1].to_i + pins.to_i == 10 && frame < 10
      second = false
      frame += 1
    end
  end
end

puts total
