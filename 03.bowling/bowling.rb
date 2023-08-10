# frozen_string_literal: true

scores = ARGV[0].split(',').to_a

total_score = 0
index = 0
frame = 1

while frame < 11
  if scores[index] == 'X'
    total_score += 10
    total_score += if scores[index + 1] == 'X'
                     10
                   else
                     scores[index + 1].to_i
                   end

    total_score += if scores[index + 2] == 'X'
                     10
                   else
                     scores[index + 2].to_i
                   end

    index += 1
  else
    temp = scores[index].to_i + scores[index + 1].to_i
    total_score += if temp < 10
                     temp
                   elsif scores[index + 2] == 'X'
                     (temp + 10)
                   else
                     (temp + scores[index + 2].to_i)
                   end
    index += 2
  end
  frame += 1
end

puts total_score
